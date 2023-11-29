{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.dircolors;
in {
  options.dotfiles.dircolors = {
    enable = mkEnableOption "Enable dircolors";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    programs.dircolors.enable = true;

    home.file."/Users/dsn/.config/dircolors".source = ./config;
  };
}
