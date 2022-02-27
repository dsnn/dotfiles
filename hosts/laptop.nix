# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let overlays = import ../modules/overlays.nix;
in {
  imports = [
    ./laptop-hw.nix
    ../modules/boot.nix
    ../modules/zfs.nix
    ../modules/nix.nix
    ../modules/locale.nix
    ../modules/timezone.nix
    ../modules/ssh.nix
    ../modules/pulseaudio.nix
    ../modules/networkmanager.nix
    ../modules/awesomewm.nix
    ../modules/libinput.nix
    ../modules/default-share.nix
    ../modules/user.nix
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

