{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.dsn.cifs;

  inherit (lib)
    mkOption
    types
    mkIf
    mkEnableOption
    ;

  secretName = config.dsn.cifs.credentials.secretName;
  sopsFile = config.dsn.cifs.credentials.sopsFile;
  targetPath = config.dsn.cifs.credentials.targetPath;

  mkShare = name: {
    device = "//dss/${name}";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  };
in
{
  options.dsn.cifs = {
    enable = mkEnableOption "Enable cifs";

    fileSystems = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            device = mkOption { type = types.str; };
            fsType = mkOption { type = types.str; };
            options = mkOption {
              type = types.listOf types.str;
              default = [ ];
            };
          };
        }
      );
      default = {
        "/mnt/private" = mkShare "private";
        "/mnt/share" = mkShare "share";
        "/mnt/share2" = mkShare "share2";
      };
      description = "Custom mount point definitions.";
    };

    credentials = mkOption {
      type = types.submodule {
        options = {
          secretName = mkOption {
            type = types.str;
            default = "credentials";
            description = "Name of the sops secret.";
          };

          sopsFile = mkOption {
            type = types.path;
            default = ../../secrets/cifs.yaml;
            description = "Path to the sops file.";
          };

          targetPath = mkOption {
            type = types.str;
            default = "nixos/smb-secrets";
            description = "Path in /etc to link secret to.";
          };
        };
      };
      default = { };
      description = "Configuration for SMB/CIFS credentials via sops and /etc.";
    };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [ cifs-utils ];

    sops.secrets."${secretName}" = {
      sopsFile = sopsFile;
    };

    environment.etc."${targetPath}" = {
      source = config.sops.secrets."${secretName}".path;
      mode = "0600";
    };

    fileSystems = lib.mkMerge [
      (lib.mkIf (config.dsn.cifs.fileSystems != { }) config.dsn.cifs.fileSystems)
    ];
  };
}
