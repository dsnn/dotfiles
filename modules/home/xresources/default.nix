{ pkgs, ... }: {

  # TODO: https://github.com/catppuccin/xresources

  xresources.properties = {
    "Xft.dpi" = "120";
    "Xft.autohint" = "0";
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = "1";
    "Xft.antialias" = "1";
    "Xft.rgba" = "rgb";
  };

}
