{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.xdg;
in
{

  options.dsn.xdg = {
    enable = mkEnableOption "Enable xdg";
  };

  config = mkIf cfg.enable {

    xdg = {
      enable = true;
      cacheHome = "${config.home.homeDirectory}/.local/cache";
      configHome = "${config.home.homeDirectory}/.config";
      dataHome = "${config.home.homeDirectory}/.local/share";
      userDirs = {
        desktop = "";
        documents = "";
        download = "$HOME/Downloads";
        music = "";
        pictures = "";
        publicShare = "";
        templates = "";
        videos = "";
        createDirectories = false;
      };
    };
  };
}
