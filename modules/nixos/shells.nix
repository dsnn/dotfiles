{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (pkgs.stdenv) isDarwin;
  cfg = config.dsn.shells;
in
{
  options.dsn.shells = {
    enable = mkEnableOption "Enable common shells";
  };

  config = mkIf cfg.enable {
    environment = {
      shells = with pkgs; [
        bash
        zsh
      ];
    };
    # // optionalAttrs isDarwin {
    #   loginShell = pkgs.zsh;
    #   systemPath = [ "/opt/homebrew/bin" ];
    #   pathsToLink = [ "/Applications" ];
    # };
  };
}
