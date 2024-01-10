{ config, pkgs, ... }:
let jellyfin = config.users.users.jellyfin.name;
in {

  users.users.jellyfin = {
    isSystemUser = true;
    group = jellyfin;
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
}
