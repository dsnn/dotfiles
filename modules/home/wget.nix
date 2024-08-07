{ config, pkgs, lib, ... }:
with lib;
let cfg = config.dsn.wget;
in {

  options.dsn.wget = { enable = mkEnableOption "Enable wget"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wget ];

    programs.zsh.shellAliases = {
      wget = ''wget --hsts-file="$HOME/.config/wget"/wget-hsts'';
    };
  };
}
