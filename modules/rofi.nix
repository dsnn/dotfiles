{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    cycle = true;
    theme = "Pop-Dark";
  };
}
