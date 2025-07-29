{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.docker;
in
{
  options.dsn.docker = {
    enable = mkEnableOption "Enable docker";
  };

  config = mkIf cfg.enable {
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
