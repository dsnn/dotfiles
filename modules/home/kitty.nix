{ config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    # font = {
    #   name = "Robot Mono Medium Nerd Font Complete";
    #   # package = (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; });
    # };
    settings = { font_size = 12; };
    keybindings = {
      "ctrl+alt+n" = "new_tab";
      "ctrl+alt+q" = "close_tab";
      "ctrl+alt+l" = "next_tab";
      "ctrl+alt+h" = "previous_tab";
    };
  };
}
