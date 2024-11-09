{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.dsn.jellyfin;
  group = config.users.users.jellyfin.name;
in
{
  options.dsn.jellyfin = {
    enable = mkEnableOption "Enable jellyfin";
  };

  config = mkIf cfg.enable {
    users.users.jellyfin = {
      isSystemUser = true;
      inherit group;
    };

    users.groups.jellyfin = { };

    environment.systemPackages = with pkgs; [
      pkgs.jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];

    # default port 8096
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
