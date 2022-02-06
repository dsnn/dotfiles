{ config, pkgs, ... }: {

  ## Something wrong w/ $DISPLAY (on qemu/xrdp?) ? 

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    config = ./polybar-config;
    script = ''
      /run/current-system/sw/bin/sleep 1
      polybar nord &
      # for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
      #   MONITOR=$m polybar nord &
      # done
    '';
  };

}
