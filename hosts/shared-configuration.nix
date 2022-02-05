# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "zfs" ];

  time.timeZone = "Europe/Stockholm";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.ens18.useDHCP = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xrdp.enable = true;
  services.xrdp.port = 3389;
  services.xrdp.openFirewall = true;

  users.defaultUserShell = pkgs.zsh;

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
  ];

  services.openssh = {
    enable = true;
    forwardX11 = false;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
  services.samba = { enable = true; };
  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  fileSystems."/mnt/private" = {
    device = "//dss/private";
    fsType = "cifs";
    options = let
      # prevent hanging on network split
      automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";
  system.stateVersion = "21.11";
}

