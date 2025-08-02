{
  flake.modules.services.traefik = {
    # ...

    # environment.systemPackages = with pkgs; [
    #   openssl
    #   git
    #   vim
    #   nodejs
    #   yarn
    #   nodePackages.npm
    # ];

    # security.acme = {
    #   acceptTerms = true;
    #   defaults.email = "name@domain.com";
    #   certs."domain.com" = {
    #     domain = "domain.com";
    #     extraDomainNames = [ "*.domain.com" ];
    #     dnsProvider = "ovh";
    #     dnsPropagationCheck = true;
    #     credentialsFile = "/etc/nixos/credentials.txt";
    #   };
    # };

    services.traefik = {
      enable = true;
      staticConfigOptions = {
        global = {
          checkNewVersion = false;
          sendAnonymousUsage = false;
        };
        entryPoints = {
          web = {
            address = ":80";
            http.redirections.entrypoint = {
              to = "websecure";
              scheme = "https";
            };
          };
          websecure.address = ":443";
        };
        providers.docker.exposedByDefault = false;
      };
      dynamicConfigOptions = {

        # tls = {
        #   stores.default = {
        #     defaultCertificate = {
        #       certFile = "/var/lib/acme/domain.com/cert.pem";
        #       keyFile = "/var/lib/acme/domain.com/key.pem";
        #     };
        #   };
        #
        #   certificates = [{
        #     certFile = "/var/lib/acme/domain.com/cert.pem";
        #     keyFile = "/var/lib/acme/domain/key.pem";
        #     stores = "default";
        #   }];
        # };

        http.routers.hello = {
          rule = "Host(`movies.domain.com`)";
          entryPoints = [ "websecure" ];
          service = "hello";
          tls = true;
        };

        http.services.hello = {
          loadBalancer.servers = [ { url = "https://192.168.2.2:8096"; } ];
        };

      };

    };

    # systemd.services."hello-world" = {
    #   description = "Hello World";
    #   after = [ "network.target" ];
    #   wantedBy = [ "multi-user.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.nodejs}/bin/node /etc/nixos/app.js";
    #     Restart = "always";
    #     RestartSec = "3";
    #   };
    # };
    #
    networking.firewall.allowedTCPPorts = [
      80
      443
      8000
    ];

    users.users.traefik.extraGroups = [ "docker" ];
  };
}
