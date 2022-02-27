{ config, pkgs, lib, ... }: {
  imports = [
    ../modules/git.nix
    ../modules/starship.nix
    ../modules/zsh.nix
    ../modules/fzf.nix
    ../modules/tmux.nix
    ../modules/xdg.nix
    ../modules/kitty.nix
    ../modules/lazygit.nix
  ];

  # allow proprietary packages
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixUnstable;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;
}
