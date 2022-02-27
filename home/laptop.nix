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
    ../modules/rofi.nix
    ../modules/packages.nix
    ../modules/kitty.nix
    ../modules/lazygit.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixUnstable;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;

  services.network-manager-applet = { enable = true; };

  # compositor for xorg
  # services.picom.enable = true;
  # services.picom.fade = true;
  # services.picom.shadow = true;
  # services.picom.shadowOpacity = "0.3";

  home.packages = with pkgs; [
    discord
    spotify
    kodi
    google-chrome
    sstp
    teamspeak_client
    remmina
    xfce.thunar
    feh
    xcape
    wireguard
    # blueman
    # imagemagick 
    # redshift
    # upower
    # ffmpeg
  ];

  # services.gvfs.enable = true;
  # services.tumbler.enable = true;

  # eww
}
