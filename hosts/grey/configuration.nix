{ pkgs, ... }: {

  programs.nix-ld.dev.enable = true;

  imports = [
    ../../system/common.nix
    ../../system/nixos/cicd
    ../../system/nixos/cifs.nix
    ../../system/nixos/security.nix
    ../../system/nixos/services/fail2ban.nix
    ../../system/nixos/services/homepage-dashboard.nix
    ../../system/nixos/services/jellyfin.nix
    ../../system/nixos/services/openssh.nix
    ../../system/nixos/users.nix
    ./hardware.nix
  ];

  services.printing = {
    enable = true;
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    drivers = with pkgs; [ cups-bjnp gutenprint ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  # networking.wg-quick.interfaces = {
  #    wg0 = {
  #      address = [ "192.168.1.1/24" "fdc9:281f:04d7:9ee9::2/64" ];
  #      dns = [ "10.0.0.1" "fdc9:281f:04d7:9ee9::1" ];
  #      privateKeyFile = "/root/wireguard-keys/privatekey";
  #
  #      peers = [
  #        {
  #          publicKey = "{server public key}";
  #          presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
  #          allowedIPs = [ "0.0.0.0/0" "::/0" ];
  #          endpoint = "{server ip}:51820";
  #          persistentKeepalive = 25;
  #        }
  #      ];
  #    };
  #  };
  #

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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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

