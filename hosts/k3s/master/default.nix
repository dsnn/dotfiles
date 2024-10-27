{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  dsn = {
    common.enable = true;
    # openssh.enable = true;
    user.enable = true;
    sops.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    qemuGuest.enable = true;
    openssh.enable = true;
  };

  # required: fails on lxc
  systemd.mounts = [
    {
      where = "/sys/kernel/debug";
      enable = false;
    }
  ];

  networking = {
    enableIPv6 = false;
    defaultGateway = "192.168.2.1";
  };

  programs.zsh.enable = true;

  system = {
    stateVersion = "24.05";
  };

  boot.isContainer = true;
}
