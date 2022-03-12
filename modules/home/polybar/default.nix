{ config, pkgs, ... }: {

  # polybar
  services.polybar.enable = true;

  services.polybar.package = pkgs.polybarFull;

  # config
  services.polybar.config = pkgs.substituteAll {
    src = ./config;
    interface = "enp6s0";
  };

  # launch script
  services.polybar.script = ''
    for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
      MONITOR=$m polybar mybar &
    done
  '';

}
