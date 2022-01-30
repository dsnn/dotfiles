{ config, pkgs, lib, ... }:

# for package and service info: 
# https://github.com/nix-community/home-manager/tree/master/

let
  zshsettings = import ./zsh.nix pkgs;
  gitsettings = import ./git.nix pkgs;
  packages = import ./packages.nix pkgs;
  starshipsettings = import ./starship.nix pkgs;
  profileDirectory = config.home.profileDirectory;

in {
  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  config.allowUnfree = true;

  home.username = "dsn";
  home.homeDirectory = "/home/dsn";
  home.stateVersion = "22.05";

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

  # programs.keychain  = {};
  # programs.lazygit   = {};
  # programs.z-lua     = {};

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink ~/dotfiles/nvim;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
}
