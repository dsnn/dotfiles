{ ... }: {

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # change focus
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # swap
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east

      # move
      ctrl + alt - h : yabai -m window --warp west
      ctrl + alt - j : yabai -m window --warp south
      ctrl + alt - k : yabai -m window --warp north
      ctrl + alt - l : yabai -m window --warp east

      # change focus (displays)
      alt - s: yabai -m display --focus west
      alt - g: yabai -m display --focus east

      # rotate
      alt - r : yabai -m space --rotate 90

      # fullscreen
      alt - f : yabai -m window --toggle zoom-fullscreen

      # toggle float
      alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2

      # balance
      alt - e : yabai -m space --balance

      # move window to space #
      shift + alt - 1 : yabai -m window --space 1;
      shift + alt - 2 : yabai -m window --space 2;
      shift + alt - 3 : yabai -m window --space 3;
      shift + alt - 4 : yabai -m window --space 4;
      shift + alt - 5 : yabai -m window --space 5;
      shift + alt - 6 : yabai -m window --space 6;
      shift + alt - 7 : yabai -m window --space 7;
    '';
  };
}

