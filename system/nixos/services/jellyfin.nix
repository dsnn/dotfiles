{ config, pkgs, ... }:
let jellyfin = config.users.users.jellyfin.name;
in {

  users.users.jellyfin = {
    isSystemUser = true;
    createHome = true;
    group = jellyfin;
  };
  users.groups.jellyfin = { };

  environment.systemPackages =
    [ pkgs.jellyfin pkgs.jellyfin-web pkgs.jellyfin-ffmpeg ];

  # defaulr port 8096
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = jellyfin;
    group = jellyfin;
  };

}
