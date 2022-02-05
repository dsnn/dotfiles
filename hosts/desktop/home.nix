{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../shared-home.nix
    ../../modules/xdg.nix
    ../../modules/awesome.nix
    ../../modules/packages.nix
    ../../modules/kitty.nix
    ../../modules/lazygit.nix
  ];
}
