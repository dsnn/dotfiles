{ config, pkgs, ... }: {

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    config = {
      "bar/top" = { modules-right = "date"; };
      "module/date" = {
        type = "internal/date";
        date = "%Y-%m-%d%";
      };
    };
    script = ''
      for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
        MONITOR=$m polybar top &
      done
    '';
  };

}
