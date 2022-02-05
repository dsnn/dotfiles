{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../shared-home.nix
    ../../modules/xdg.nix
    # ../../modules/neovim.nix
    ../../modules/packages.nix
    ../../modules/lazygit.nix
  ];
}
