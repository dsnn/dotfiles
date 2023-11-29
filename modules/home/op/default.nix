{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.op;
in {
  options.dotfiles.op = {
    enable = mkEnableOption "Enable op";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.initExtra = ''
      if command -v op &> /dev/null
      then
        eval "$(op completion zsh)"; compdef _op op
      fi
    '';
  };
}
