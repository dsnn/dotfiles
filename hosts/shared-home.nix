{ config, pkgs, lib, ... }: {

  imports = [
    ../modules/git.nix
    ../modules/starship.nix
    ../modules/zsh.nix
    ../modules/fzf.nix
    ../modules/tmux.nix
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;
  # programs.z-lua     = {};

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ];
}
