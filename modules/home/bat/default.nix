{ pkgs, lib, config, ... }:
with lib;
let cfg = config.dotfiles.bat;
in {
  options.dotfiles.bat = {
    enable = mkEnableOption "Enable bat";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    # TODO: https://github.com/catppuccin/bat
    # https://github.com/nix-community/home-manager/blob/master/modules/programs/bat.nix

    programs.bat.enable = true;
    programs.bat.config.theme = "TwoDark";
    programs.zsh.shellAliases = { cat = "bat"; };

  };
}
