{ config, pkgs, ... }: {

  # TODO: https://github.com/catppuccin/kitty
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix

  programs.kitty.enable = true;

  programs.kitty.settings = { font_size = 11; };

  programs.kitty.keybindings = {
    "ctrl+alt+n" = "new_tab";
    "ctrl+alt+q" = "close_tab";
    "ctrl+alt+l" = "next_tab";
    "ctrl+alt+h" = "previous_tab";
  };
}
