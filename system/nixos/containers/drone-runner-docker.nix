{ config, ... }:
let dronerunner = config.users.users.drone-runner-docker.name;
in {

  sops.secrets = { "drone" = { owner = dronerunner; }; };

  users.users.drone-runner-docker = {
    isSystemUser = true;
    group = dronerunner;
  };
  users.groups.drone-runner-docker = { };

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    drone-runner-docker = {
      autoStart = true;
      image = "drone/drone-runner-docker:1";
      environmentFiles = [ config.sops.secrets.drone.path ];
      environment = {
        DRONE_RPC_HOST = "127.0.0.1:3030";
        DRONE_RPC_PROTO = "http";
        DRONE_RUNNER_CAPACITY = "2";
        DRONE_RUNNER_NAME = "drone-runner-docker";
      };
      extraOptions = [ "--network=host" ];
      volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
    };
  };

  # systemd.services.drone-runner-docker = {
  #   enable = true;
  #   wantedBy = [ "multi-user.target" ];
  #   script = ''
  #     ${pkgs.drone-runner-docker}/bin/drone-runner-docker
  #   '';
  #   restartIfChanged = false;
  #   serviceConfig = {
  #     EnvironmentFile = [ config.sops.secrets.drone.path ];
  #     Environment = [
  #       "DRONE_RPC_PROTO=http"
  #       "DRONE_RPC_HOST=localhost:3030"
  #       "DRONE_RUNNER_CAPACITY=2"
  #       "DRONE_RUNNER_NAME=drone-runner-docker"
  #       "DRONE_RUNNER_VOLUMES=/var/run/docker.sock:/var/run/docker.sock"
  #     ];
  #     User = droneserver;
  #     Group = droneserver;
  #   };
  # };
}
