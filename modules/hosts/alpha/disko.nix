{
  flake.modules.nixos.disko-btrfs =
    { lib, ... }:
    {
      disko.devices = {
        disk.disk1 = {
          type = "disk";
          device = lib.mkDefault "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                priority = 1;
                size = "1M";
                type = "EF02";
              };
              ESP = {
                priority = 1;
                name = "ESP";
                size = "1G";
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
                  mountpoint = "/mnt/root";
                  mountOptions = [ "compress=zstd" ];
                  subvolumes = {
                    "/rootfs" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
}
