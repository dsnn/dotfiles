{
  # host specific settings
  flake.modules.homeManager.nixos.home.homeDirectory = "/home/dsn";

  flake.modules.nixos.nixos =
    { pkgs, ... }:
    {
      networking = {
        hostName = "nixos";
        dhcpcd.enable = true;
        interfaces.eth0.useDHCP = true;
      };

      # boot = {
      #   loader.grub = {
      #     efiSupport = true;
      #     efiInstallAsRemovable = true;
      #   };
      # };
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "/dev/sda";
      boot.loader.grub.useOSProber = true;

      nixpkgs = {
        hostPlatform = "x86_64-linux";
      };

      system = {
        stateVersion = "25.11";
      };

      nixpkgs.config.allowUnfree = true;

      networking.networkmanager.enable = true;
    };
}
