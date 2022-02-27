{ config, pkgs, lib, ... }: {
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/starship.nix
    ../../modules/home/zsh.nix
    ../../modules/home/fzf.nix
    ../../modules/home/tmux.nix
    ../../modules/home/xdg.nix
    ../../modules/home/kitty.nix
    ../../modules/home/lazygit.nix
  ];

  # allow proprietary packages
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixUnstable;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;
}
