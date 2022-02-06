{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../shared-home.nix
    ../../services/polybar.nix
    ../../modules/xdg.nix
    ../../modules/rofi.nix
    ../../modules/i3.nix
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
  ];
  # eww
}
