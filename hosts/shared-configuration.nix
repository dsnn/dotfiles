# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ ../modules/nix.nix ../modules/ssh.nix ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    supportedFilesystems = [ "zfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Europe/Stockholm";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.ens18.useDHCP = true;
  };

  programs.nm-applet.enable = true;

  services.samba = { enable = true; };
  services.xrdp = {
    enable = true;
    port = 3389;
    openFirewall = true;
    defaultWindowManager = "xterm";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
    };
    zfs = {
      autoSnapshot.enable = true;
      autoScrub.enable = true;
    };
  };

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

  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
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

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  nix.gc = {
    automatic = true;
    dates = "03:15";
  };
  system.stateVersion = "21.11";
}

