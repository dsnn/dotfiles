{ config, ... }:
let registry = config.users.users.registry.name;
in {

  networking.firewall.allowedTCPPorts = [ 5000 ];

  sops.secrets = {
    "docker-registry-http-secret" = { owner = registry; };
    "docker-registry-htpasswd" = { owner = registry; };
  };

  users.users.registry = {
    isSystemUser = true;
    createHome = true;
    group = registry;
  };
  users.groups.registry = { };

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    registry = {
      autoStart = true;
      image = "registry:2";
      environment = {
        USER_UID = "1000";
        USER_GID = "1000";
        REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY = "/data";
        REGISTRY_HTTP_SECRET =
          config.sops.secrets."docker-registry-http-secret".path;
      };
      volumes = [
        "/home/dsn/containers/registry:/data"
        "/etc/timezone:/etc/timezone:ro"
        "/etc/localtime:/etc/localtime:ro"
      ];
      ports = [ "5000:5000" ];
    };
  };

  services.nginx.virtualHosts."registry.dsnn.io" = {
    locations."/".proxyPass = "http://127.0.0.1:5000";
  };
}
