{ config, ... }:
let docker-registry = config.users.users.docker-registry.name;
in {

  networking.firewall.allowedTCPPorts = [ 5000 ];

  sops.secrets = {
    "docker-registry-http-secret" = {
      sopsFile = ../../../secrets/cicd.yaml;
      owner = docker-registry;
    };
    "docker-registry-htpasswd" = {
      sopsFile = ../../../secrets/cicd.yaml;
      owner = docker-registry;
    };
  };

  services.dockerRegistry = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = 5000;
    enableDelete = true;
    enableGarbageCollect = true;
    garbageCollectDates = "daily";
    # https://distribution.github.io/distribution#override-specific-configuration-options 
    extraConfig = {
      REGISTRY_AUTH = "htpasswd";
      REGISTRY_AUTH_HTPASSWD_PATH =
        config.sops.secrets."docker-registry-htpasswd".path;
      REGISTRY_AUTH_HTPASSWD_REALM = "Registry Realm";
    };
  };

  services.nginx.virtualHosts."registry.dsnn.io" = {
    locations."/".proxyPass = "http://127.0.0.1:5000";
  };
}
