# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ ./desktop-hw.nix ];

  # let myAwesome = import ../modules/overlays.nix;
  # nixpkgs.overlays = [ myAwesome ];

  # enable flakes
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "03:15";
    };
  };

  # allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];

  # Configure dual booting 
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.useOSProber = true;

  time.timeZone = "Europe/Stockholm";
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  networking.networkmanager.enable = true;

  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = false;
  # networking.hostId = "8d549888";
  # networking.hostName = "dsn";
  networking.hostId = "55aa39de";
  networking.hostName = "dsn"; # Define your hostname.

  # services.systemd-udev-settle.enable = false;
  # services.NetworkManager-wait-online.enable = false;

  services.samba = { enable = true; };

  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  services.openssh.enable = true;
  # services.openssh.forwardX11 = false;
  # services.openssh.permitRootLogin = "no";
  # services.openssh.passwordAuthentication = false;
  # services.openssh.kbdInteractiveAuthentication = false;

  # services.xrdp.enable = true;
  # services.xrdp.port = 3389;
  # services.xrdp.openFirewall = true;
  # services.xrdp.defaultWindowManager = "${pkgs.awesome}/bin/awesome";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "se";
  services.xserver.dpi = 120;
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;

  services.xserver.videoDrivers = [ " nvidia " ];

  # compositor for xorg
  # services.picom.enable = true;
  # services.picom.fade = true;
  # services.picom.shadow = true;
  # services.picom.shadowOpacity = 0.3;

  # services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+awesome";
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks # package manager for Lua modules
      luadbi-mysql # database abstraction layer
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "sv-latin1";

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

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

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
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

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}

