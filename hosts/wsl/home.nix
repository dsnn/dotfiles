{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../../modules/home/git.nix
    ../../modules/home/starship.nix
    ../../modules/home/zsh.nix
    ../../modules/home/fzf.nix
    ../../modules/home/tmux.nix
    ../../modules/home/xdg.nix
    ../../modules/home/packages.nix
    ../../modules/home/lazygit.nix
  ];

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;
}
