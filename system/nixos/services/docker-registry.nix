{ config, ... }:
let droneserver = config.users.users.droneserver.name;
in {

  networking.firewall.allowedTCPPorts = [ 5000 ];

  sops.secrets = {
    "docker-registry-http-secret" = { owner = droneserver; };
    "docker-registry-htpasswd" = { owner = droneserver; };
  };

  users.users.droneserver = {
    isSystemUser = true;
    createHome = true;
    group = droneserver;
  };
  users.groups.droneserver = { };

  services.dockerRegistry = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 5000;
    enableDelete = true;
    enableGarbageCollect = true;
    garbageCollectDates = "daily";
    extraConfig = {
      http.secret = config.sops.secrets."docker-registry-http-secret".path;
      # auth.htpasswd.realm = "Registry Realm";
      # auth.htpasswd.path = "/auth/htpasswd";
      # config.sops.secrets."docker-registry-htpasswd".path;
      # environment:
      #       REGISTRY_AUTH: htpasswd
      #       REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
      #       REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
    };
  };

  services.nginx.virtualHosts."registry.dsnn.io" = {
    locations."/".proxyPass = "http://127.0.0.1:5000";
  };
}
