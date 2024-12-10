{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # dsn = {
  #   common.enable = true;
  #   # openssh.enable = true;
  #   user.enable = true;
  #   sops.enable = true;
  # };

  nixpkgs.config.allowUnfree = true;

  services = {
    qemuGuest.enable = true;
    openssh.enable = true;
  };

  networking = {
    hostName = "srv-nixos-01";
    enableIPv6 = false;
    interfaces.ens18.ipv4.addresses = [
      {
        address = "192.168.2.111";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.2.1";
  };

  programs.zsh.enable = true;

  system = {
    stateVersion = "24.11";
  };
}
