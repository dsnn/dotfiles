{ pkgs, ... }: {

  imports = [
    ../../system/common.nix
    ../../system/nixos/cifs.nix
    ../../system/nixos/containers/drone-runner-docker.nix
    ../../system/nixos/security.nix
    ../../system/nixos/security.nix
    ../../system/nixos/services/fail2ban.nix
    ../../system/nixos/services/openssh.nix
    ../../system/nixos/users.nix
    ../../system/sops.nix
    ./hardware.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostId = "426c1ab5";
  networking.hostName = "black";
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

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    gcc
    inetutils
    pavucontrol
    pciutils
    terraform
  ];

  system.stateVersion = "23.05";
}

