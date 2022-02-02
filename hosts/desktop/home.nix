{ config, pkgs, lib, ... }:

# for package and service info: 
# https://github.com/nix-community/home-manager/tree/master/

let
  zshsettings = import ../../modules/zsh.nix { inherit pkgs; };
  gitsettings = import ../../modules/git.nix { inherit pkgs; };
  packages = import ../../modules/packages.nix { inherit pkgs; };
  starshipsettings = import ../../modules/starship.nix { inherit pkgs lib; };
  profileDirectory = config.home.profileDirectory;

in {
  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  xdg = {
    enable = true;
    cacheHome = ~/.local/cache;
    configHome = ~/.config;
    dataHome = ~/.local/share;
  };

  home.packages = packages.common ++ packages.dev;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.git = gitsettings;
  programs.starship = starshipsettings;
  programs.zsh = zshsettings;

  xsession.enable = true;

  # programs.keychain  = {};
  # programs.lazygit   = {};
  # programs.z-lua     = {};

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink ~/dotfiles/nvim;

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ];
}
