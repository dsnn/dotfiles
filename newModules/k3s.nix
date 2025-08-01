{
  flake.modules.services.k3s =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    with lib;
    let
      cfg = config.dsn.k3s-server;
    in
    {
      options.dsn.k3s-server = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable Single Node K3S Cluster.";
        };
        services = {
          traefik = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
              If enabled traefik will be enabled on k3s cluster
            '';
          };
        };
      };

      config =
        let
          k3sAdmissionPlugins = [
            "DefaultStorageClass"
            "DefaultTolerationSeconds"
            "LimitRanger"
            "MutatingAdmissionWebhook"
            "NamespaceLifecycle"
            "NodeRestriction"
            "PersistentVolumeClaimResize"
            "Priority"
            "ResourceQuota"
            "ServiceAccount"
            "TaintNodesByCondition"
            "ValidatingAdmissionWebhook"
          ];
          k3sDisabledServices =
            [ ]
            # ++ lib.optionals (cfg.services.flannel == false) [ "flannel" ]
            # ++ lib.optionals (cfg.services.servicelb == false) [ "servicelb" ]
            # ++ lib.optionals (cfg.services.coredns == false) [ "coredns" ]
            # ++ lib.optionals (cfg.services.local-storage == false) [ "local-storage" ]
            # ++ lib.optionals (cfg.services.metrics-server == false) [ "metrics-server" ]
            ++ lib.optionals (cfg.services.traefik == false) [ "traefik" ];
          k3sExtraFlags = [
            "--kubelet-arg=config=/etc/rancher/k3s/kubelet.config"
            "--node-label \"k3s-upgrade=false\""
            "--kube-apiserver-arg anonymous-auth=true"
            "--kube-controller-manager-arg bind-address=0.0.0.0"
            "--kube-scheduler-arg bind-address=0.0.0.0"
            "--etcd-expose-metrics"
            "--secrets-encryption"
            "--write-kubeconfig-mode 0644"
            "--kube-apiserver-arg='enable-admission-plugins=${lib.concatStringsSep "," k3sAdmissionPlugins}'"
          ];
          # ++ lib.lists.optionals (cfg.services.flannel == false) [
          #   "--flannel-backend=none"
          #   "--disable-network-policy"
          # ]
          # ++ lib.optionals (cfg.services.kube-proxy == false) [
          #   "--disable-cloud-controller"
          #   "--disable-kube-proxy"
          # ]
          # ++ lib.optionals cfg.prepare.cilium [
          #   "--kubelet-arg=register-with-taints=node.cilium.io/agent-not-ready:NoExecute"
          # ];
          k3sDisableFlags = builtins.map (service: "--disable ${service}") k3sDisabledServices;
          k3sCombinedFlags = lib.concatLists [
            k3sDisableFlags
            k3sExtraFlags
          ];
        in
        mkIf cfg.enable {

          sops.secrets."k3s_token" = {
            sopsFile = ../../secrets/k3s.yaml;
          };

          environment = {
            systemPackages = with pkgs; [
              age
              kubernetes-helm
              helmfile
              git
              jq
              k9s
              krelay
              kubectl
              nfs-utils
              openiscsi
              openssl_3
              sops
            ];

            etc = {
              "rancher/k3s/kubelet.config" = {
                mode = "0750";
                text = ''
                  apiVersion: kubelet.config.k8s.io/v1beta1
                  kind: KubeletConfiguration
                  maxPods: 250
                '';
              };
              "rancher/k3s/k3s.service.env" = {
                mode = "0750";
                text = ''
                  K3S_KUBECONFIG_MODE="644"
                '';
              };
            };
          };

          networking.firewall = {
            enable = true;
            allowedTCPPorts = [
              80 # http
              222 # git ssh
              443 # https
              445 # samba
              6443 # kubernetes api
              8080 # reserved http
              10250 # k3s metrics
            ];
            allowedTCPPortRanges = [
              {
                from = 2379;
                to = 2380;
              } # etcd
            ];
          };

          services = {
            prometheus.exporters.node = {
              enable = true;
            };
            k3s = {
              enable = true;
              role = "server";
              tokenFile = config.sops.secrets."k3s_token".path;
              clusterInit = true;
              environmentFile = "/etc/rancher/k3s/k3s.service.env";
              extraFlags = lib.concatStringsSep " " k3sCombinedFlags;
            };
          };
        };
    };
}
