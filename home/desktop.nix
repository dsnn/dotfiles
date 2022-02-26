{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ./shared.nix
    ../modules/xdg.nix
    ../modules/rofi.nix
    ../modules/packages.nix
    ../modules/kitty.nix
    ../modules/lazygit.nix
  ];

  # xsession.enable = true;
  # programs.direnv.enable = true;

  # enable network manager applet
  services.network-manager-applet = { enable = true; };

  # create symlinks to local shares
  home.file."private".source = config.lib.file.mkOutOfStoreSymlink /mnt/private;
  home.file."share".source = config.lib.file.mkOutOfStoreSymlink /mnt/share;
  home.file."share2".source = config.lib.file.mkOutOfStoreSymlink /mnt/share2;

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
    wireguard
    freerdp
    slack
  ];
  # eww
}
