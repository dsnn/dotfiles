{ config, pkgs, ...}: {

  programs.dircolors.enable = true;

  home.file."/Users/dsn/.config/dircolors".source = ./config;
}
