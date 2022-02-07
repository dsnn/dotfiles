{ config, pkgs, lib, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../shared-home.nix
    ../../modules/i3.nix
    ../../modules/xdg.nix
    ../../modules/rofi.nix
    ../../modules/packages.nix
    ../../modules/kitty.nix
    ../../modules/lazygit.nix
    ../../services/polybar.nix
  ];

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  # programs.direnv.enable = true;
  home.packages = with pkgs; [
    discord
    spotify
    kodi
    google-chrome
    sstp
    teamspeak_client
  ];
  # eww
}
