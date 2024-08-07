{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.dsn.fail2ban;
  group = config.users.users.jellyfin.name;
in {
  options.dsn.fail2ban = { enable = mkEnableOption "Enable fail2ban"; };

  config = mkIf cfg.enable {
    users.users.jellyfin = {
      isSystemUser = true;
      group = group;
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
