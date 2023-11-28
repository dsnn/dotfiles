{ pkgs, lib, config, ... }:
with lib;
let cfg = config.dotfiles.wget;
in {
  options.dotfiles.wget = {
    enable = mkEnableOption "Enable wget";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ wget ];

    programs.zsh.shellAliases = {
      wget = ''wget --hsts-file="$HOME/.config/wget"/wget-hsts'';
    };
  };
}
