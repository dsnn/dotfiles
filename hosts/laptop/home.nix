{ config, pkgs, lib, ... }: {

  imports = [
    ../../modules/home/git.nix
    ../../modules/home/starship.nix
    ../../modules/home/zsh.nix
    ../../modules/home/fzf.nix
    ../../modules/home/tmux.nix
    ../../modules/home/xdg.nix
    ../../modules/home/rofi.nix
    ../../modules/home/packages.nix
    ../../modules/home/kitty.nix
    ../../modules/home/lazygit.nix
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
