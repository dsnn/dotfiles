{ pkgs, config, lib, ... }:
let
  inherit (pkgs) stdenv;
  inherit (lib) mkIf;
in
{

  # TODO: https://github.com/catppuccin/kitty
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix

  programs.kitty.enable = true;

  programs.kitty.settings = {
    font_size = 14;
    scrollback_lines = 10000;
    enable_audio_bell = false;
    update_check_interval = 0;
  };

  programs.kitty.darwinLaunchOptions = mkIf stdenv.isDarwin [
    "--single-instance"
    "--directory=/tmp/my-dir"
    "--listen-on=unix:/tmp/my-socket"
  ];

  programs.kitty.keybindings = {
    "ctrl+alt+n" = "new_tab";
    "ctrl+alt+q" = "close_tab";
    "ctrl+alt+l" = "next_tab";
    "ctrl+alt+h" = "previous_tab";
  };
}
