{
  modulesPath,
  lib,
  pkgs,
  ...
}:
let
  username = "dsn";
  initialHashedPassword = "$2b$05$yPIF0wnops49ceqHXaDsM.h.RdJ1TLbyNUvQrZFjEGI1wF1KWVORu"; # asd123
  pubKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAaLTAnk7ZuDsWIcahlr0SWKfq9BlwSJTyE1c6CGktKB"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCblbdi9GiPOhBlH1aSn3+/0w8w7OVP+jNVbjX0iOf31WMJpyGi8X1ybsZfjrAQ2VoHuX/dN1BJlvOGO36PcDRsXDKE/+Db9VcJR8vzs4d1Nik8lbmjXgWHPv6Ig8SDVrqanV/6Yv9AbgZFqIbfqIsW41i/zkVt8wXYewATI6bjHs5gWox+5h/NBBu6bTCD1He4I8v6/1Dg3D/9o0fmhrwGOdd7W1zxPorjUC9uziUCc4uOnnTH5n1K59TvMYeUsdYtkToew7b1fJAsC1FY09GrgyQ+y+O07oGNLI9NyckEMIi+1hsSi3dNwLG2Y/lqcHM/YgdY3iez63h+W02tEuaF%"
  ];
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

  system.stateVersion = "25.05";
}
