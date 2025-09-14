{
  # host specific settings
  flake.modules.homeManager.alpha.home.homeDirectory = "/home/dsn";

  flake.modules.nixos.alpha =
    { pkgs, ... }:
    {
      networking = {
        hostName = "alpha";
        dhcpcd.enable = true;
        interfaces.eth0.useDHCP = true;
        interfaces.wlp58s0.useDHCP = true;
      };

      boot = {
        loader.grub = {
          efiSupport = true;
          efiInstallAsRemovable = true;
        };
        kernelModules = [ "iwlwifi" ];
      };

      nixpkgs = {
        hostPlatform = "x86_64-linux";
      };

      system = {
        stateVersion = "25.05";
      };

      nixpkgs.config.allowUnfree = true;

      hardware = {
        logitech.wireless.enable = true;
        logitech.wireless.enableGraphical = true;
        enableRedistributableFirmware = true;
        firmware = [ pkgs.linux-firmware ];
      };
      networking.networkmanager.enable = true;
      networking.networkmanager.wifi.backend = "wpa_supplicant";
    };
}
