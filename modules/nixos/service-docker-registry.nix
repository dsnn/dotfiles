{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.docker-registry;
  docker-registry = config.users.users.docker-registry.name;
in {

  options.dsn.docker-registry = {
    enable = mkEnableOption "Enable docker registry";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
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
      openFirewall = true;
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
  };
}
