# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let overlays = import ../modules/overlays.nix;
in {
  imports = [ ./desktop-hw.nix ../modules/sops.nix ];

  nixpkgs.overlays = [ overlays ];

  # secrets specifications
  # for more options, e.g. permissions: https://github.com/Mic92/sops-nix#deploy-example
  # sops.secrets.user-password.neededForUsers = true;
  sops.secrets.samba-credentials = { };
  sops.secrets.nmconnection-work-vpn = { };

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

  time.timeZone = "Europe/Stockholm";
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  networking.networkmanager.enable = true;

  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  # networking.interfaces.wlp4s0.useDHCP = false;
  # networking.interfaces.enp5s0.useDHCP = true;

  #  network id & hostname
  networking.hostId = "55aa39de";
  networking.hostName = "dsn";

  environment.etc."NetworkManager/system-connections/work.nmconnection".source =
    "${config.sops.secrets.nmconnection-work-vpn.path}";

  # dont wait for network iface 
  systemd.services.NetworkManager-wait-online.enable = false;

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

  # enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "se";
  services.xserver.dpi = 120;
  services.xserver.xkbOptions = "eurosign:e";

  # enable gdm 
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;

  services.xserver.videoDrivers = [ " nvidia " ];

  # awesomewm
  services.xserver.displayManager.defaultSession = "none+awesome";
  services.xserver.windowManager.awesome = {
    enable = true;
    package = pkgs.awesome-git;
    luaModules = with pkgs.luaPackages; [
      luarocks # package manager for Lua modules
      luadbi-mysql # database abstraction layer
    ];
  };

  # locale & keymap
  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "sv-latin1";

  # enable flash support for ergodox ez 
  hardware.keyboard.zsa.enable = true;

  # pulseaudio 
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

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
  ];

  # user settings
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    # plugdev is required for ergodox ez 
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" "plugdev" ];
    hashedPassword =
      "$6$n0/53jiplgIPWu8s$m4xx3iAHaYbQBxDtxLWFB0tnO0NpHl761ZgD3piAZkhQyMXRwcGGApDUKTF841PneckL9MgljztMRlx5MNyF70";
    # passwordFile = config.sops.secrets.user-password.path;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF"
    ];
  };

  # mount network shares 
  fileSystems = {
    "/mnt/private" = {
      device = "//dss/private";
      fsType = "cifs";
      options = let
        automount_opts =
          "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in [
        "${automount_opts},credentials=${config.sops.secrets.samba-credentials.path}"
      ];
    };
  };

  fileSystems = {
    "/mnt/share" = {
      device = "//dss/share";
      fsType = "cifs";
      options = let
        automount_opts =
          "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in [
        "${automount_opts},credentials=${config.sops.secrets.samba-credentials.path}"
      ];
    };
  };

  fileSystems = {
    "/mnt/share2" = {
      device = "//dss/share2";
      fsType = "cifs";
      options = let
        automount_opts =
          "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in [
        "${automount_opts},credentials=${config.sops.secrets.samba-credentials.path}"
      ];
    };
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}
