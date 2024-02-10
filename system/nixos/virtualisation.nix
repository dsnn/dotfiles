{ ... }: {

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "zfs";
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
    extraOptions = "--insecure-registry='http://192.168.2.2:5000'";
  };

  # TODO: review this (fails building VM)
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
}
