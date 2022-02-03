{ config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    settings = { font_size = 12; };
    keybindings = {
      "ctrl+alt+n" = "new_tab";
      "ctrl+alt+q" = "close_tab";
      "ctrl+alt+h" = "next_tab";
      "ctrl+alt+l" = "previous_tab";
    };
  };
}
