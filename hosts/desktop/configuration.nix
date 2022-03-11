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
    ../../modules/system/ergodox.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/awesomewm.nix
    ../../modules/system/cifs.nix
    ../../modules/system/user.nix
    ../../modules/sops.nix
  ];

  nixpkgs.overlays = [ overlays ];
  nixpkgs.config.allowUnfree = true;

  networking.hostId = "55aa39de";
  networking.hostName = "dsn";

  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  # networking.interfaces.wlp4s0.useDHCP = false;
  # networking.interfaces.enp5s0.useDHCP = true;

  # testing xfce
  # services.xserver.desktopManager.xterm.enable = false;
  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.displayManager.defaultSession = "xfce";

  # work vpn profile
  sops.secrets.nmconnection-work-vpn = { };
  environment.etc."NetworkManager/system-connections/work.nmconnection".source =
    "${config.sops.secrets.nmconnection-work-vpn.path}";

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
    inetutils
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}
