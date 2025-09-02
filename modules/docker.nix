{
  flake.modules = {
    homeManager.docker =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      let
        aliases = {
          ds = "docker ps -a";
          di = "docker images";
          drm = ''docker rm $(docker ps -qa --no-trunc --filter "status=exited")'';
          drmi = "docker rmi $(docker images -q -f dangling=true)";
        };
      in
      {
        home.packages = with pkgs; [ colima ];
        programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable aliases;
      };

    darwin.docker =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          docker
        ];
      };

    nixos.docker =
      { ... }:
      {
        # programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable aliases;

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
  };

}
