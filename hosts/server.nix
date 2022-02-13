# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let mod = "Mod4";
in {
  imports = [ ./server-hw.nix ];

  # enable flakes
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];

  time.timeZone = "Europe/Stockholm";

  networking.hostId = "8d549888";
  networking.hostName = "alpha";

  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  networking.interfaces.ens18.useDHCP = true;

  services.samba = { enable = true; };

  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  services.openssh.enable = true;
  # services.openssh.forwardX11 = false;
  # services.openssh.permitRootLogin = "no";
  # services.openssh.passwordAuthentication = false;
  # services.openssh.kbdInteractiveAuthentication = false;

  # Configure keymap in X11
  services.xserver.enable = true;
  services.xserver.layout = "us";

  # disable default lightdm
  services.xserver.displayManager.startx.enable = true;

  services.xrdp.enable = true;
  services.xrdp.port = 3389;
  services.xrdp.openFirewall = true;
  # services.xrdp.defaultWindowManager = "${pkgs.awesome}/bin/awesome";

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = false;

  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "sv-latin1";

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker.enable = true;

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

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" "docker" ];
    hashedPassword =
      "$6$n0/53jiplgIPWu8s$m4xx3iAHaYbQBxDtxLWFB0tnO0NpHl761ZgD3piAZkhQyMXRwcGGApDUKTF841PneckL9MgljztMRlx5MNyF70";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF"
    ];
  };

  fileSystems = {
    "/mnt/private" = {
      device = "//dss/private";
      fsType = "cifs";
      options = let
        automount_opts =
          "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
    };
  };

  fileSystems = {
    "/mnt/share" = {
      device = "//dss/share";
      fsType = "cifs";
      options = let
        automount_opts =
          "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
    };
  };

  fileSystems = {
    "/mnt/share2" = {
      device = "//dss/share2";
      fsType = "cifs";
      options = let
        automount_opts =
          "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
    };
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}
