{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
  ];

  dsn = {
    common.enable = true;
    systemPackages = {
      enableMonitoringPkgs = true;
      enableNetworkingPkgs = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader.grub = {
      devices = [ ];
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    isContainer = false;
  };

  programs.zsh.enable = true;

  services.qemuGuest.enable = true;

  networking = {
    hostName = "nixos-dev";
    dhcpcd.enable = true;
    interfaces.eth0.useDHCP = true;
  };

  system = {
    stateVersion = "24.05";
  };
}
