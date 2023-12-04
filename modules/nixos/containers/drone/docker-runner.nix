{ config, pkgs, ... }: {

  systemd.services.drone-runner-docker = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.drone-runner-docker}/bin/drone-runner-docker
    '';

    ### MANUALLY RESTART SERVICE IF CHANGED
    restartIfChanged = false;
    serviceConfig = {
      Environment = {
        DRONE_RPC_PROTO = "http";
        DRONE_RPC_HOST = "localhost:3030";
        DRONE_RUNNER_CAPACITY = 2;
        DRONE_RUNNER_NAME = "drone-runner-docker";
      };
      EnvironmentFile = config.sops.secrets.drone.path;
      User = "drone-runner-docker";
      Group = "drone-runner-docker";
    };
  };
}
