# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "zfs" ];

  networking.hostId = "8d549888";
  networking.hostName = "alpha";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  nixpkgs.config.allowUnfree = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.displayManager.lightdm.enable = true;

  # services.xserver.displayManager.defaultSession = "none+awesome";
  # services.xserver.windowManager.awesome = {
  #   enable = true;
  #   luaModules = with pkgs.luaPackages; [
  #     luarocks # is the package manager for Lua modules
  #     luadbi-mysql # Database abstraction layer
  #   ];
  # };

  services.xrdp.enable = true;
  services.xrdp.port = 3389;
  services.xrdp.openFirewall = true;
  services.xrdp.defaultWindowManager = "${pkgs.awesome}/bin/awesome";
  # services.xrdp.defaultWindowManager = "xterm";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
  };
  users.users.dsn.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF"
  ];

  environment.systemPackages = with pkgs; [
    coreutils
    firefox
    git
    man
    mkpasswd
    vim
    wget
    home-manager
    cifs-utils
    gcc
    xrdp
  ];

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  services.samba = { enable = true; };
  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  fileSystems."/mnt/private" = {
    device = "//dss/private";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
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

