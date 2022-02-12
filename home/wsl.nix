{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ./shared.nix
    ../modules/xdg.nix
    ../modules/packages.nix
    ../modules/lazygit.nix
  ];
}
