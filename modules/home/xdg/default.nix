{ config, pkgs, ... }: {
  xdg.enable = true;
  xdg.cacheHome = "$HOME/.local/cache";
  xdg.configHome = "$HOME/.config";
  xdg.dataHome = "$HOME/.local/share";
  xdg.userDirs = {
    desktop = "";
    documents = "";
    download = "$HOME/Download";
    music = "";
    pictures = "";
    publicShare = "";
    templates = "";
    videos = "";
    createDirectories = false;
  };
}
