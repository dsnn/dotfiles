{ ... }:
{
  disko.devices = {
    disk.disk1 = {
      device = "/dev/vda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          ESP = {
            priority = 1;
            name = "ESP";
            start = "1M";
            end = "128M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # Override existing partition
              mountpoint = "/";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
          };
          # https://github.com/nix-community/disko/blob/master/example/btrfs-subvolumes.nix
          # root = {
          #   size = "100%";
          #   content = {
          #     type = "btrfs";
          #     extraArgs = [ "-f" ]; # Override existing partition
          #     # Subvolumes must set a mountpoint in order to be mounted,
          #     # unless their parent is mounted
          #     subvolumes = {
          #       # Subvolume name is different from mountpoint
          #       "/rootfs" = {
          #         mountpoint = "/";
          #       };
          #       # Subvolume name is the same as the mountpoint
          #       "/home" = {
          #         mountOptions = [ "compress=zstd" ];
          #         mountpoint = "/home";
          #       };
          #       # Sub(sub)volume doesn't need a mountpoint as its parent is mounted
          #       "/home/user" = { };
          #       # Parent is not mounted so the mountpoint must be set
          #       "/nix" = {
          #         mountOptions = [
          #           "compress=zstd"
          #           "noatime"
          #         ];
          #         mountpoint = "/nix";
          #       };
          #       # Subvolume for the swapfile
          #       "/swap" = {
          #         mountpoint = "/.swapvol";
          #         swap = {
          #           swapfile.size = "20M";
          #           swapfile2.size = "20M";
          #           swapfile2.path = "rel-path";
          #         };
          #       };
          #     };
          #
          #     mountpoint = "/partition-root";
          #     swap = {
          #       swapfile = {
          #         size = "20M";
          #       };
          #       swapfile1 = {
          #         size = "20M";
          #       };
          #     };
          #   };
          # };
        };
      };
    };
  };
}
# {
#   disko = {
#     # Do not let Disko manage fileSystems.* config for NixOS.
#     # Reason is that Disko mounts partitions by GPT partition names, which are
#     # easily overwritten with tools like fdisk. When you fail to deploy a new
#     # config in this case, the old config that comes with the disk image will
#     # not boot either.
#     enableConfig = false;
#
#     devices = {
#       # Define a disk
#       disk.main = {
#         # Size for generated disk image. 2GB is enough for me. Adjust per your need.
#         imageSize = "10G";
#         # Path to disk. When Disko generates disk images, it actually runs a QEMU
#         # virtual machine and runs the installation steps. Whether your VPS
#         # recognizes its hard disk as "sda" or "vda" doesn't matter. We abide to
#         # Disko's QEMU VM and use "vda" here.
#         device = "/dev/vda";
#         type = "disk";
#         # Parititon table for this disk
#         content = {
#           # Use GPT partition table. There seems to be some issues with MBR support
#           # from Disko.
#           type = "gpt";
#           # Partition list
#           partitions = {
#             # Compared to MBR, GPT partition table doesn't reserve space for MBR
#             # boot record. We need to reserve the first 1MB for MBR boot record,
#             # so Grub can be installed here.
#             boot = {
#               size = "1M";
#               type = "EF02"; # for grub MBR
#               # Use the highest priority to ensure it's at the beginning
#               priority = 0;
#             };
#
#             # ESP partition, or "boot" partition as you may call it. In theory,
#             # this config will support VPSes with both EFI and BIOS boot modes.
#             ESP = {
#               name = "ESP";
#               # Reserve 512MB of space per my own need. If you use more/less
#               # on your boot partition, adjust accordingly.
#               size = "512M";
#               type = "EF00";
#               # Use the second highest priority so it's before the remaining space
#               priority = 1;
#               # Format as FAT32
#               content = {
#                 type = "filesystem";
#                 format = "vfat";
#                 # Use as boot partition. Disko use the information here to mount
#                 # partitions on disk image generation. Use the same settings as
#                 # fileSystems.*
#                 mountpoint = "/boot";
#                 mountOptions = [
#                   "fmask=0077"
#                   "dmask=0077"
#                 ];
#               };
#             };
#
#             # Parition to store the NixOS system, use all remaining space.
#             nix = {
#               size = "100%";
#               # Format as Btrfs. Change per your needs.
#               content = {
#                 type = "filesystem";
#                 format = "btrfs";
#                 # Use as the Nix partition. Disko use the information here to mount
#                 # partitions on disk image generation. Use the same settings as
#                 # fileSystems.*
#                 mountpoint = "/nix";
#                 mountOptions = [
#                   "compress-force=zstd"
#                   "nosuid"
#                   "nodev"
#                 ];
#               };
#             };
#           };
#         };
#       };
#     };
#   };
# }
