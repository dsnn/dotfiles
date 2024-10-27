{ pkgs, ... }:
{

  programs.nix-ld.dev.enable = true;

  imports = [
    # ../modules/nixos/avahi.nix
    # ../modules/nixos/cups.nix
    ../common.nix
    ../modules/nixos/cicd
    ../modules/nixos/cifs.nix
    ../modules/nixos/security.nix
    ../modules/nixos/fail2ban.nix
    ../modules/nixos/homepage-dashboard.nix
    ../modules/nixos/jellyfin.nix
    ../modules/nixos/openssh.nix
    ../modules/nixos/users.nix
    ./hardware.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostId = "199f97e0";
    hostName = "grey";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # allow packer http server port
  networking.firewall.allowedTCPPorts = [ 8802 ];

  systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    timesyncd.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    printing = {
      enable = true;
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
      drivers = with pkgs; [
        cups-bjnp
        gutenprint
      ];
    };
  };

  time.timeZone = "Europe/Stockholm";
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
    packer
    colmena
  ];

  system.stateVersion = "23.05";
}
