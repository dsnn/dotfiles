# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let mod = "Mod4";
in {
  imports = [
    ./server-hw.nix
    ../modules/boot.nix
    ../modules/zfs.nix
    ../modules/nix.nix
    ../modules/xrdp.nix
    ../modules/locale.nix
    ../modules/timezone.nix
    ../modules/ssh.nix
    ../modules/sops.nix
    ../modules/networkmanager.nix
    ../modules/awesomewm.nix
    ../modules/default-share.nix
    ../modules/user.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostId = "8d549888";
  networking.hostName = "alpha";

  networking.useDHCP = false;
  networking.interfaces.ens18.useDHCP = true;

  environment.systemPackages = with pkgs; [
    coreutils
    git
    man
    vim
    wget
    home-manager
    cifs-utils
    gcc
    xrdp
    zsh
    docker
    docker-compose
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}

