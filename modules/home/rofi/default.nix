{ config, pkgs, ... }: {

  home.packages = with pkgs; [ kitty ];

  programs.rofi.enable = true;
  programs.rofi.terminal = "${pkgs.kitty}/bin/kitty";
  programs.rofi.cycle = true;
  programs.rofi.theme = "android_notification";
}
