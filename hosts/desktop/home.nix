{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../shared-home.nix
    ../../modules/xdg.nix
    ../../modules/i3.nix
    ../../modules/packages.nix
    ../../modules/kitty.nix
    ../../modules/lazygit.nix
  ];

  home.packages = with pkgs; [ discord spotify kodi google-chrome sstp ];
  # teamspeak 
}
