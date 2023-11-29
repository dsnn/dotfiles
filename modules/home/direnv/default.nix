{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.direnv;
in {
  options.dotfiles.direnv = {
    enable = mkEnableOption "Enable direnv";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    # programs.zsh.initExtra = ''
    #   if command -v direnv &> /dev/null
    #   then
    #     eval "$(direnv hook zsh)"
    #   fi
    # '';

    programs.direnv.enable = true;
  };
}
