{ pkgs, ... }: {
  imports = [
    ../../system/common.nix
    #../../system/nixos/cifs.nix
    ../../system/nixos/containers/gitea.nix
    ../../system/nixos/services/fail2ban.nix
    ../../system/nixos/services/openssh.nix
    ../../system/nixos/security.nix
    ../../system/nixos/users.nix
    ../../system/nixos/virtualisation.nix
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
  # services.timesyncd.enable = true;
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

