{ config, pkgs, ... }:
let
  cifsShare = name: {
    device = "//dss/${name}";
    fsType = "cifs";
    options = let
      automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  };
in {

  # for more options, e.g. permissions: https://github.com/Mic92/sops-nix#deploy-example
  sops.secrets.samba-credentials = { };

  # mount default network shares 
  fileSystems."/mnt/private" = cifsShare "private";
  fileSystems."/mnt/share" = cifsShare "share";
  fileSystems."/mnt/share2" = cifsShare "share2";
}
