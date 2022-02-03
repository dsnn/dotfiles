{ config, pkgs, ... }: {
  xdg = {
    enable = true;
    cacheHome = ~/.local/cache;
    configHome = ~/.config;
    dataHome = ~/.local/share;
    configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink ~/dotfiles/nvim;
  };
}
