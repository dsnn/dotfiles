{
  flake.modules.services.jellyfin =
    { config, pkgs }:
    {
      users.users.jellyfin = {
        isSystemUser = true;
        group = config.users.users.jellyfin.name;
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
