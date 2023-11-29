{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.tmuxp;
in {
  options.dotfiles.tmuxp = {
    enable = mkEnableOption "Enable tmuxp";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    # home.packages = with pkgs; [ tmuxp lsof ];
    programs.tmux.tmuxp.enable = true;

    home.file."${config.home.homeDirectory}/.config/tmuxp".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/modules/home/tmuxp/profiles";

    programs.zsh.initExtra = ''
      export TMUXP_CONFIGDIR=$HOME/.config/tmuxp
    '';
  };
}
