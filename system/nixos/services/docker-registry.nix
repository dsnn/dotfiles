{ config, ... }:
let docker-registry = config.users.users.docker-registry.name;
in {

  networking.firewall.allowedTCPPorts = [ 5000 ];

  sops.secrets = {
    "docker-registry-http-secret" = { owner = docker-registry; };
    "docker-registry-htpasswd" = { owner = docker-registry; };
  };

  services.dockerRegistry = {
    enable = true;
    listenAddress = "192.168.2.2"; # required. 127.0.0.1 doesn't work (?)
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
    locations."/".proxyPass = "http://192.168.2.2:5000";
  };
}
