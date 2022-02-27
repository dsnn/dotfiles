{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../modules/git.nix
    ../modules/starship.nix
    ../modules/zsh.nix
    ../modules/fzf.nix
    ../modules/tmux.nix
    ../modules/xdg.nix
    ../modules/packages.nix
    ../modules/lazygit.nix
  ];

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;
}
