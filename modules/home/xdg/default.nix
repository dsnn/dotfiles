{ pkgs, lib, config, ... }:
with lib;
let cfg = config.dotfiles.xdg;
in {
  options.dotfiles.xdg = {
    enable = mkEnableOption "Enable xdg";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

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
