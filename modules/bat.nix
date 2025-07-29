{ config, pkgs, lib, ... }:
with lib;
let cfg = config.dsn.bat;
in {

  options.dsn.bat = { enable = mkEnableOption "Enable bat"; };

  config = mkIf cfg.enable {
    programs.zsh.shellAliases = { cat = "bat"; };

    programs.bat = {
      enable = true;
      config = { theme = "catppuccin"; };
      # https://github.com/eth-p/bat-extras/tree/master
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
      themes = {
        catppuccin = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
          file = "Catppuccin-mocha.tmTheme";
        };
      };
    };
  };
}
