{ config, pkgs, ...}: {
  home.file."/Users/dsn/.config/karabiner".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/modules/home/karabiner/src";
}
