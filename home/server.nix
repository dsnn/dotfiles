{ config, pkgs, lib, ... }:
let
  cifsShare = name: {
    device = "//dss/${name}";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "credentials=${config.sops.secrets.samba-credentials.path}"
    ];
  };
in {
  imports = [
    ./shared.nix
    ../modules/xdg.nix
    ../modules/kitty.nix
    ../modules/lazygit.nix
  ];

  # secrets specifications
  # for more options, e.g. permissions: https://github.com/Mic92/sops-nix#deploy-example
  sops.secrets.samba-credentials = { };

  # allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  # package channel
  nix.package = pkgs.nixUnstable;

  # enable flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # collect garbage & optimize 
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];

  # timezone
  services.timesyncd.enable = true;
  time.timeZone = "Europe/Stockholm";

  # locale 
  i18n.defaultLocale = "en_US.UTF-8";

  # keyboard 
  console.keyMap = "sv-latin1";

  # font
  console.font = "Lat2-Terminus16";

  # networkmanager
  networking.networkmanager.enable = true;

  networking.useDHCP = false;
  # TODO: enable iface

  networking.hostId = "55aa39de";
  networking.hostName = "alpha";

  # dont wait for network iface 
  systemd.services.NetworkManager-wait-online.enable = false;

  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  services.openssh.enable = true;

  # enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "se";
  services.xserver.dpi = 120;
  services.xserver.xkbOptions = "eurosign:e";

  home.packages = with pkgs; [
    cifs-utils
    coreutils
    bat
    fzf
    git
    htop
    keychain
    nawk
    starship
    tmux
    unzip
    wget
    xclip
    zsh
    pciutils
    jq
    vim
    _1password # cli
    age
    sops
    docker
    docker-compose
  ];

  # user settings
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    # plugdev is required for ergodox ez 
    extraGroups =
      [ "wheel" "video" "audio" "disk" "networkmanager" "plugdev" "docker" ];
    hashedPassword =
      "$6$n0/53jiplgIPWu8s$m4xx3iAHaYbQBxDtxLWFB0tnO0NpHl761ZgD3piAZkhQyMXRwcGGApDUKTF841PneckL9MgljztMRlx5MNyF70";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF"
    ];
  };

  # mount network shares 
  fileSystems."/mnt/private" = cifsShare "private";
  fileSystems."/mnt/share" = cifsShare "share";
  fileSystems."/mnt/share2" = cifsShare "share2";

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11";
}
