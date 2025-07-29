{ config, lib, ... }:
with lib;
let cfg = config.dsn.karabiner;
in {

  options.dsn.karabiner = { enable = mkEnableOption "Enable karabiner"; };

  config = mkIf cfg.enable {
    home.file."/Users/dsn/.config/karabiner".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/home/karabiner/src";
  };
}
