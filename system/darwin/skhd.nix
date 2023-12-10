{ lib, config, ... }:
with lib;
let cfg = config.mine.services.skhd;
in {
  options.mine.services.skhd = { enable = mkEnableOption "Enable skhd"; };

  config = mkIf cfg.enable {
    services.skhd = {
      enable = true;
      skhdConfig = ''
        # change window focus within space
        alt - j : yabai -m window --focus south
        alt - k : yabai -m window --focus north
        alt - h : yabai -m window --focus west
        alt - l : yabai -m window --focus east

        # swap windows
        shift + alt - j : yabai -m window --swap south
        shift + alt - k : yabai -m window --swap north
        shift + alt - h : yabai -m window --swap west
        shift + alt - l : yabai -m window --swap east

        # move window and split
        ctrl + alt - j : yabai -m window --warp south
        ctrl + alt - k : yabai -m window --warp north
        ctrl + alt - h : yabai -m window --warp west
        ctrl + alt - l : yabai -m window --warp east

        # change focus between external displays (left and right)
        alt - s: yabai -m display --focus west
        alt - g: yabai -m display --focus east

        # rotate layout
        shift + alt - r : yabai -m space --rotate 270

        # toggle window float
        shift + alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2

        # maximize a window
        shift + alt - m : yabai -m window --toggle zoom-fullscreen

        # balance out tree of windows (resize to occupy same area)
        shift + alt - e : yabai -m space --balance

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
  };
}

