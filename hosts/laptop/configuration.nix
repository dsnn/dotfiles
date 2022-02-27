# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let overlays = import ../../modules/system/overlays.nix;
in {
  imports = [
    ./hardware.nix
    ../../modules/system/boot.nix
    ../../modules/system/zfs.nix
    ../../modules/system/nix.nix
    ../../modules/system/locale.nix
    ../../modules/system/timezone.nix
    ../../modules/system/ssh.nix
    ../../modules/system/pulseaudio.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/awesomewm.nix
    ../../modules/system/libinput.nix
    ../../modules/system/cifs.nix
    ../../modules/system/user.nix
  ];

  nixpkgs.overlays = [ overlays ];
  nixpkgs.config.allowUnfree = true;

  networking.hostId = "8a09c44d";
  networking.hostName = "dsl";

  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp58s0.useDHCP = true;
  networking.interfaces.wwp0s20f0u6i12.useDHCP = true;

  # disable rpfilter for wireguard
  networking.firewall.checkReversePath = false;

  environment.systemPackages = with pkgs; [
    cifs-utils
    coreutils
    gcc
    git
    home-manager
    man
    tree
    vim
    wget
    zsh
    pciutils
    pavucontrol
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}

