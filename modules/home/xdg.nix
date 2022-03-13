{ config, pkgs, ... }: {

  xdg.enable = true;
  xdg.cacheHome = ~/.local/cache;
  xdg.configHome = ~/.config;
  xdg.dataHome = ~/.local/share;
  xdg.userDirs = {
    desktop = "";
    documents = "";
    download = "~/download";
    music = "";
    pictures = "";
    publicShare = "";
    templates = "";
    videos = "";
    createDirectories = false;
  };

  # config symlinks
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink ~/dotfiles/modules/home/nvim;

  xdg.configFile."awesome".source =
    config.lib.file.mkOutOfStoreSymlink ~/dotfiles/modules/home/awesome;

  xdg.configFile."polybar".source =
    config.lib.file.mkOutOfStoreSymlink ~/dotfiles/modules/home/polybar;
}
