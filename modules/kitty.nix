{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.dsn.kitty;
  inherit (pkgs.stdenv) isDarwin;
  inherit (lib) mkIf;
in
{

  options.dsn.kitty = {
    enable = mkEnableOption "Enable kitty";
  };

  config = mkIf cfg.enable {

    programs = {

      kitty = {
        enable = true;
        settings = {
          font_size = 14;
          scrollback_lines = 10000;
          enable_audio_bell = false;
          update_check_interval = 0;
        };

        darwinLaunchOptions = mkIf isDarwin [
          "--single-instance"
          "--directory=/tmp/my-dir"
          "--listen-on=unix:/tmp/my-socket"
        ];

        keybindings = {
          "ctrl+alt+n" = "new_tab";
          "ctrl+alt+q" = "close_tab";
          "ctrl+alt+l" = "next_tab";
          "ctrl+alt+h" = "previous_tab";
        };
      };
    };

  };
}
