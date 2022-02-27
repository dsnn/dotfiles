{ config, pkgs, ... }: {

  # supported filesystem types
  boot.supportedFilesystems = [ "zfs" ];

  services.zfs.autoSnapshot.enable = true;

  # periodic scrubbing of ZFS pools 
  services.zfs.autoScrub.enable = true;
}
