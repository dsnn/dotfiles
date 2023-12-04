{ pkgs, ... }: {
  imports = [
    ../../system/common.nix
    #../../system/nixos/cifs.nix
    ../../system/nixos/fail2ban.nix
    ../../system/nixos/openssh.nix
    ../../system/nixos/security.nix
    ../../system/nixos/users.nix
    ../../system/sops.nix
    ./hardware.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostId = "8d549888";
  networking.hostName = "black";
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "Europe/Stockholm";
  services.timesyncd.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    inetutils
    pavucontrol
    pciutils
  ];

  system.stateVersion = "21.11";
}

