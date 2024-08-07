{ config, pkgs, lib, ... }:
with lib;
let cfg = config.dsn.vivid;
in {

  options.dsn.vivid = { enable = mkEnableOption "Enable vivid"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ vivid ];
    programs.zsh.initExtra = ''
      export LS_COLORS="$(vivid generate catppuccin-mocha)"
    '';
  };
}
