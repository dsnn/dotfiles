{ config, ... }: {
  home.file."/Users/dsn/.config/karabiner".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/home/programs/karabiner/src";
}
