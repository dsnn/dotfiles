{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.dsn.just;
in
{

  options.dsn.just = {
    enable = mkEnableOption "Enable just";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ just ];
    programs.zsh = {
      shellAliases = {
        j = "just";
      };
    };
  };
}
