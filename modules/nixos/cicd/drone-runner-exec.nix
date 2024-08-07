{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.drone-runner-exec;
  droneserver = config.users.users.droneserver.name;
in {

  options.dsn.drone-runner-exec = {
    enable = mkEnableOption "Enable drone runner exec";
  };

  config = mkIf cfg.enable {
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

    systemd.services.drone-runner-exec = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
      script = ''
        ${pkgs.drone-runner-exec}/bin/drone-runner-exec
      '';
      restartIfChanged = true;
      serviceConfig = {
        EnvironmentFile = [ config.sops.secrets.drone.path ];
        Environment = [
          "DRONE_RPC_PROTO=http"
          "DRONE_RPC_HOST=127.0.0.1:3030"
          "DRONE_RUNNER_CAPACITY=2"
          "DRONE_RUNNER_NAME=drone-runner-exec"
        ];
        User = droneserver;
        Group = droneserver;
      };
    };
  };
}
