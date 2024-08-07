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

  environment.systemPackages = with pkgs; [ cifs-utils ];

  sops.secrets."credentials" = { sopsFile = ../../secrets/cifs.yaml; };

  environment.etc."nixos/smb-secrets".source =
    config.sops.secrets."credentials".path;
  environment.etc."nixos/smb-secrets".mode = "0600";

  fileSystems."/mnt/private" = cifsShare "private";
  fileSystems."/mnt/share" = cifsShare "share";
  fileSystems."/mnt/share2" = cifsShare "share2";
}
