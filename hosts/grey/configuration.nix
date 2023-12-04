{ pkgs, ... }: {
  imports = [
    ../../modules/common.nix
    #../../modules/nixos/cifs.nix
    ../../modules/nixos/containers/gitea.nix
    ../../modules/nixos/fail2ban.nix
    ../../modules/nixos/openssh.nix
    ../../modules/nixos/security.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/virtualisation.nix
    ./hardware.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostId = "199f97e0";
  networking.hostName = "grey";
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "Europe/Stockholm";
  services.timesyncd.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    inetutils
    pavucontrol
    pciutils
  ];

  system.stateVersion = "23.05";
}

