{
  modulesPath,
  lib,
  myvars,
  pkgs,
  ...
}:
let
  inherit (myvars) username initialHashedPassword pubKeys;
in
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];
    loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.qemuGuest.enable = true;
  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  networking = {
    defaultGateway = {
      address = "192.168.2.1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    interfaces.eth0.useDHCP = false;
  };

  users.users.dsn = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      username
      "users"
      "wheel"
    ];

    initialHashedPassword = lib.mkForce initialHashedPassword; # asd123
    openssh.authorizedKeys.keys = pubKeys;
  };

  users.users.root = {
    initialHashedPassword = lib.mkForce initialHashedPassword;
    openssh.authorizedKeys.keys = pubKeys;
  };

  system.stateVersion = "24.11";
}
