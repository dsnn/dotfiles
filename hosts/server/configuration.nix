# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let mod = "Mod4";
in {
  imports = [
    ./hardware.nix
    ../../modules/system/boot.nix
    ../../modules/system/zfs.nix
    ../../modules/system/nix.nix
    ../../modules/system/xrdp.nix
    ../../modules/system/locale.nix
    ../../modules/system/timezone.nix
    ../../modules/system/ssh.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/awesomewm.nix
    ../../modules/system/cifs.nix
    ../../modules/system/user.nix
    ../../modules/sops.nix
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

