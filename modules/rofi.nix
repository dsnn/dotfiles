{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    cycle = true;
    theme = "android_notification";
  };
}
