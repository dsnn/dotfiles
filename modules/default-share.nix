{ config, pkgs, ... }:
let
  cifsShare = name: {
    device = "//dss/${name}";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "credentials=${config.sops.secrets.samba-credentials.path}"
    ];
  };
in {

  # secrets specifications
  # for more options, e.g. permissions: https://github.com/Mic92/sops-nix#deploy-example
  sops.secrets.samba-credentials = { };

  # mount default network shares 
  fileSystems."/mnt/private" = cifsShare "private";
  fileSystems."/mnt/share" = cifsShare "share";
  fileSystems."/mnt/share2" = cifsShare "share2";
}
