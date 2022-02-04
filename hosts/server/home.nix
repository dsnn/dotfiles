{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../../modules/git.nix
    ../../modules/starship.nix
    ../../modules/zsh.nix
    ../../modules/fzf.nix
    ../../modules/xdg.nix
    ../../modules/awesome.nix
    # ../../modules/neovim.nix
    ../../modules/packages.nix
    ../../modules/kitty.nix
    ../../modules/lazygit.nix
    ../../modules/tmux.nix
  ];

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
