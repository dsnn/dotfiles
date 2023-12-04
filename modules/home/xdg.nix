{ config, ... }: {
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
}
