{ pkgs, ... }: {

  programs.nix-ld.dev.enable = true;

  imports = [
    ../../system/common.nix
    ../../system/nixos/cicd
    ../../system/nixos/cifs.nix
    ../../system/nixos/security.nix
    # ../../system/nixos/services/avahi.nix
    # ../../system/nixos/services/cups.nix
    ../../system/nixos/services/fail2ban.nix
    ../../system/nixos/services/homepage-dashboard.nix
    ../../system/nixos/services/jellyfin.nix
    ../../system/nixos/services/openssh.nix
    ../../system/nixos/users.nix
    ./hardware.nix
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.printing = {
    enable = true;
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    drivers = with pkgs; [ cups-bjnp gutenprint ];
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostId = "199f97e0";
  networking.hostName = "grey";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "Europe/Stockholm";
  services.timesyncd.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    inetutils
    pavucontrol
    pciutils
    terraform
  ];

  system.stateVersion = "23.05";
}

