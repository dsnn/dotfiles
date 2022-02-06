{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../shared-home.nix
    ../../modules/xdg.nix
    ../../modules/awesome.nix
    ../../modules/rofi.nix
    ../../modules/packages.nix
    ../../modules/kitty.nix
    ../../modules/lazygit.nix
  ];

  # programs.direnv.enable = true;
  home.packages = with pkgs; [
    discord
    spotify
    kodi
    google-chrome
    sstp
    teamspeak_client
    eww
  ];
  # teamspeak 
}
