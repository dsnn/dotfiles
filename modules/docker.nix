{

  flake.modules.nixos.docker = {
    programs.zsh.shellAliases = {
      ds = "docker ps -a";
      di = "docker images";
      drm = ''docker rm $(docker ps -qa --no-trunc --filter "status=exited")'';
      drmi = "docker rmi $(docker images -q -f dangling=true)";
      # dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
    };

    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      storageDriver = "zfs";
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    # TODO: review this
    # systemd = {
    #   timers.docker-prune = {
    #     wantedBy = [ "timers.target" ];
    #     partOf = [ "docker-prune.service" ];
    #     timerConfig.OnCalendar = "*-*-* 2:00:00";
    #   };
    #   services.docker-prune = {
    #     serviceConfig.Type = "oneshot";
    #     script = ''
    #       ${pkgs.docker}/bin/docker image prune --filter "until=72h"
    #     '';
    #     requires = [ "docker.service" ];
    #   };
    # };
  };
}
