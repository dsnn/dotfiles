{
  # host specific settings
  flake.modules.homeManager.nixos.home.homeDirectory = "/home/dsn";

  flake.modules.nixos.nixos =
    {
      lib,
      pkgs,
      nixpkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
      ];

      boot.initrd.availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "virtio_pci"
        "virtio_scsi"
        "sd_mod"
        "sr_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/cb735fc2-2eff-456b-abd4-da7d0368643d";
        fsType = "ext4";
      };

      swapDevices = [ ];

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
