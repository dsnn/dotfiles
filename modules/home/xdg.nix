{ config, lib, ... }:
with lib;
let cfg = config.dsn.xdg;
in {

  options.dsn.xdg = { enable = mkEnableOption "Enable xdg"; };

  config = mkIf cfg.enable {
    xdg.enable = true;
    xdg.cacheHome = "${config.home.homeDirectory}/.local/cache";
    xdg.configHome = "${config.home.homeDirectory}/.config";
    xdg.dataHome = "${config.home.homeDirectory}/.local/share";
    xdg.userDirs = {
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
}
