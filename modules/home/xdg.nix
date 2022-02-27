{ config, pkgs, ... }: {
  xdg = {
    enable = true;
    cacheHome = ~/.local/cache;
    configHome = ~/.config;
    dataHome = ~/.local/share;
    userDirs = {
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
    configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink ~/dotfiles/modules/home/nvim;
    configFile."awesome".source =
      config.lib.file.mkOutOfStoreSymlink ~/dotfiles/modules/home/awesome;
  };
}
