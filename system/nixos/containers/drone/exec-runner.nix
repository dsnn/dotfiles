{ config, pkgs, ... }: {

  users.users.drone-runner-exec = {
    isSystemUser = true;
    group = "drone-runner-exec";
  };

  users.groups.drone-runner-exec = { };
  # Allow the exec runner to write to build with nix
  nix.allowedUsers = [ "drone-runner-exec" ];

  systemd.services.drone-runner-exec = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.drone-runner-exec}/bin/drone-runner-exec
    '';

    ### MANUALLY RESTART SERVICE IF CHANGED
    restartIfChanged = true;

    confinement.enable = true;
    confinement.packages =
      [ pkgs.git pkgs.gnutar pkgs.bash pkgs.nixFlakes pkgs.gzip ];

    path = [ pkgs.git pkgs.gnutar pkgs.bash pkgs.nixFlakes pkgs.gzip ];

    serviceConfig = {
      Environment = {
        DRONE_RPC_PROTO = "http";
        DRONE_RPC_HOST = "127.0.0.1:3030";
        DRONE_RUNNER_CAPACITY = "2";
        DRONE_RUNNER_NAME = "drone-runner-exec";
        NIX_REMOTE = "daemon";
        PAGER = "cat";
        DRONE_DEBUG = "true";
      };

      BindPaths = [
        "/nix/var/nix/daemon-socket/socket"
        "/run/nscd/socket"
        # "/var/lib/drone"
      ];

      BindReadOnlyPaths = [
        "/etc/passwd:/etc/passwd"
        "/etc/group:/etc/group"
        "/nix/var/nix/profiles/system/etc/nix:/etc/nix"
        "${
          config.environment.etc."ssl/certs/ca-certificates.crt".source
        }:/etc/ssl/certs/ca-certificates.crt"
        "${
          config.environment.etc."ssh/ssh_known_hosts".source
        }:/etc/ssh/ssh_known_hosts"
        "${
          builtins.toFile "ssh_config" ''
            Host git.dsnn.io
            ForwardAgent yes
          ''
        }:/etc/ssh/ssh_config"
        "/etc/machine-id"
        "/etc/resolv.conf"
        "/nix/"
      ];
      EnvironmentFile = config.sops.secrets.drone.path;
      User = "drone-runner-exec";
      Group = "drone-runner-exec";
    };
  };
}
