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
    ../../modules/home/picom.nix
  ];

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;

  xresources.properties = {
    "Xft.dpi" = "120";
    "Xft.autohint" = "0";
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = "1";
    "Xft.antialias" = "1";
    "Xft.rgba" = "rgb";
  };

  # enable network manager applet
  services.network-manager-applet = { enable = true; };

  # create symlinks to local shares
  home.file."private".source = config.lib.file.mkOutOfStoreSymlink /mnt/private;
  home.file."share".source = config.lib.file.mkOutOfStoreSymlink /mnt/share;
  home.file."share2".source = config.lib.file.mkOutOfStoreSymlink /mnt/share2;

  home.packages = with pkgs; [
    discord
    feh
    freerdp
    google-chrome
    kodi
    remmina
    slack
    spotify
    sstp
    teamspeak_client
    wireguard
    xfce.thunar
  ];
}
