{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.dircolors;
in
{

  options.dsn.dircolors = {
    enable = mkEnableOption "Enable dircolors";
  };

  config = mkIf cfg.enable {
    programs.dircolors.enable = true;

    home.file."${config.home.homeDirectory}/.config/dircolors".source = ./config;
  };
}
