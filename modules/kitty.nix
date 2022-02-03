{ config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    settings = ''
      font_size 12.0

      # tab managment
      map ctrl+alt+n      new_tab
      map ctrl+alt+q      close_tab
      map ctrl+alt+h      next_tab
      map ctrl+alt+l      previous_tab
          '';

  };
}
