{ config, pkgs, ... }:
let overlays = import ../modules/overlays.nix;
in {
  imports = [
    ./desktop-hw.nix
    ../modules/boot.nix
    ../modules/zfs.nix
    ../modules/nix.nix
    ../modules/locale.nix
    ../modules/timezone.nix
    ../modules/ssh.nix
    ../modules/pulseaudio.nix
    ../modules/sops.nix
    ../modules/ergodox.nix
    ../modules/networkmanager.nix
    ../modules/awesomewm.nix
    ../modules/default-share.nix
    ../modules/user.nix
  ];

  nixpkgs.overlays = [ overlays ];

  # allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  # networking.interfaces.wlp4s0.useDHCP = false;
  # networking.interfaces.enp5s0.useDHCP = true;

  #  network id & hostname
  networking.hostId = "55aa39de";
  networking.hostName = "dsn";

  # system packages
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
    wally-cli
    age
    sops
    docker
    docker-compose
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}
