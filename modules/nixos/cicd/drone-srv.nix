{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.drone-server;
  droneserver = config.users.users.droneserver.name;
in {

  options.dsn.drone-server = { enable = mkEnableOption "Enable drone server"; };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 3030 ];

    sops.secrets.drone = {
      sopsFile = ../../../secrets/cicd.yaml;
      owner = droneserver;
    };

    users.users.droneserver = {
      isSystemUser = true;
      createHome = true;
      group = droneserver;
    };
    users.groups.droneserver = { };

    services.postgresql = {
      ensureDatabases = [ droneserver ];
      ensureUsers = [{
        name = droneserver;
        ensureDBOwnership = true;
      }];
    };

    systemd.services.drone-server = {
      wantedBy = [ "multi-user.target" ];
      script = ''
        ${pkgs.drone}/bin/drone-server
      '';
      serviceConfig = {
        EnvironmentFile = [ config.sops.secrets.drone.path ];
        Environment = [
          "DRONE_DATABASE_DATASOURCE=postgres:///droneserver?host=/run/postgresql"
          "DRONE_DATABASE_DRIVER=postgres"
          "DRONE_SERVER_PORT=:3030"
          "DRONE_SERVER_HOST=drone.dsnn.io"
          "DRONE_SERVER_PROTO=https"
          "DRONE_GITEA_SERVER=https://gitea.dsnn.io"
        ];
        User = droneserver;
        Group = droneserver;
      };
    };
  };
}
