{ config, pkgs, ... }: {

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    config = ./polybar-config;
    script = ''
      sleep
      for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
        MONITOR=$m polybar nord &
      done
          '';
  };

}
