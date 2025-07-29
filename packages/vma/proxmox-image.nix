# https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/virtualisation/proxmox-image.nix
{ modulesPath, ... }:
{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    ./configuration.nix
  ];

  proxmox = {
    qemuConf = {
      boot = "order=virtio0;ide2;net0";
      virtio0 = "local:901/base-901-disk-0";
      ostype = "cloud-init";
      cores = 4;
      memory = 4096;
      name = "nixos-cloud";
      # When restoring from VMA, check the "unique" box to ensure device mac is randomized
      net0 = "virtio=00:00:00:00:00:00,bridge=vmbr0,firewall=0";
    };
    qemuExtraConf = {
      cpu = "host";
      onboot = 1;
    };
    filenameSuffix = "901-nixos-cloud";
    cloudInit = {
      enable = true;
      defaultStorage = "local";
    };
  };

  virtualisation.diskSize = 10240;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };

  # File system according to raw-disk configuration (hosts/raw)
  # fileSystems."/" = {
  #   device = "/dev/vda3";
  #   fsType = "btrfs";
  #   options = [
  #     "compress-force=zstd"
  #     "nosuid"
  #     "nodev"
  #   ];
  # };
  #
  # fileSystems."/boot" = {
  #   device = "/dev/vda2";
  #   fsType = "vfat";
  #   options = [
  #     "fmask=0077"
  #     "dmask=0077"
  #   ];
  # };
}
