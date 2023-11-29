{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.karabiner;
in {
  options.dotfiles.karabiner = {
    enable = mkEnableOption "Enable karabiner";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.file."/Users/dsn/.config/karabiner".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/home/karabiner/src";
  };
}
