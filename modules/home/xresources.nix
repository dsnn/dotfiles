{ config, lib, ... }:
with lib;
let cfg = config.dsn.xresources;
in {

  options.dsn.xresources = { enable = mkEnableOption "Enable xresources"; };

  config = mkIf cfg.enable {
    xresources.properties = {
      "Xft.dpi" = "120";
      "Xft.autohint" = "0";
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = "1";
      "Xft.antialias" = "1";
      "Xft.rgba" = "rgb";
    };
  };
}
