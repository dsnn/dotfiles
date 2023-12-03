{ config, pkgs, ... }: {

  # enable systemd-boot
  boot.loader.systemd-boot.enable = true;

  # Whether the installation process is allowed to modify EFI boot variables
  boot.loader.efi.canTouchEfiVariables = true;
}
