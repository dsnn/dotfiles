{ config, pkgs, lib, ... }:

# for package and service info: 
# https://github.com/nix-community/home-manager/tree/master/

let
  packages = import ../../modules/packages.nix { inherit pkgs; };
  profileDirectory = config.home.profileDirectory;

in {
  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../../modules/git.nix
    ../../modules/starship.nix
    ../../modules/zsh.nix
    ../../modules/fzf.nix
    ../../modules/xdg.nix
    ../../modules/awesome.nix
  ];

  home.packages = packages.common ++ packages.dev;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;

  # programs.keychain  = {};
  # programs.lazygit   = {};
  # programs.z-lua     = {};

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ];
}
