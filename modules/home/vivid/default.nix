{ pkgs, lib, config, ... }:
with lib;
let cfg = config.dotfiles.vivid;
in {
  options.dotfiles.vivid = {
    enable = mkEnableOption "Enable vivid";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ vivid ];

    programs.zsh.initExtra = ''
      export LS_COLORS="$(vivid generate catppuccin-mocha)"
    '';
  };
}
