{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.k3s-agent;
in
{
  options.dsn.k3s-agent = {
    enable = mkEnableOption "Enable k3s agent";
    serverAddr = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = mkIf cfg.enable {

    sops.secrets."k3s_token" = {
      sopsFile = ../../secrets/k3s.yaml;
    };

    networking.firewall.allowedTCPPorts = [
      6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
      2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
    ];
    networking.firewall.allowedUDPPorts = [
      8472 # k3s, flannel: required if using multi-node for inter-node networking
    ];

    services.k3s = {
      enable = true;
      role = "agent";
      tokenFile = config.sops.secrets."k3s_token".path;
      serverAddr = cfg.serverAddr; # "https://<ip of first node>:6443";
    };
  };
}