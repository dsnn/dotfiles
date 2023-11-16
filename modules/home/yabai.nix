
{ config, pkgs, ... }: {

  # osx window managment w/ keybindings

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse          = "autoraise";
      mouse_follows_focus          = "off";
      window_placement             = "second_child";
      window_opacity               = "off";
      window_opacity_duration      = "0.0";
      window_border                = "on";
      window_border_placement      = "inset";
      window_border_width          = 2;
      window_border_radius         = 3;
      active_window_border_topmost = "off";
      window_topmost               = "on";
      window_shadow                = "float";
      active_window_border_color   = "0xff5c7e81";
      normal_window_border_color   = "0xff505050";
      insert_window_border_color   = "0xffd75f5f";
      active_window_opacity        = "1.0";
      normal_window_opacity        = "1.0";
      split_ratio                  = "0.50";
      auto_balance                 = "on";
      mouse_modifier               = "alt";
      mouse_action1                = "move";
      mouse_action2                = "resize";
      layout                       = "bsp";
      top_padding                  = 5;
      bottom_padding               = 5;
      left_padding                 = 5;
      right_padding                = 5;
      window_gap                   = 5;
    };

    extraConfig = ''
        # center mouse on window with focus
        yabai -m config mouse_follows_focus on

        # when window is dropped in center of another window, swap them (on edges it will split it)
        yabai -m mouse_drop_action swap

        yabai -m rule --add app="^System Settings$" manage=off
        yabai -m rule --add app="^Calculator$" manage=off
        yabai -m rule --add app="^Karabiner-Elements$" manage=off

        # yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        # yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
        # yabai -m rule --add label="System Preferences" app="^System Preferences$" title=".*" manage=off
        # yabai -m rule --add label="App Store" app="^App Store$" manage=off
        # yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
        # yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
        # yabai -m rule --add label="Software Update" title="Software Update" manage=off
        # yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # change window focus within space
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - h : yabai -m window --focus west
      alt - l : yabai -m window --focus east
      
      #change focus between external displays (left and right)
      alt - s: yabai -m display --focus west
      alt - g: yabai -m display --focus east
      
      # rotate layout clockwise
      shift + alt - r : yabai -m space --rotate 270
      
      # flip along y-axis
      shift + alt - y : yabai -m space --mirror y-axis
      
      # flip along x-axis
      shift + alt - x : yabai -m space --mirror x-axis
      
      # toggle window float
      shift + alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2
      
      # maximize a window
      shift + alt - m : yabai -m window --toggle zoom-fullscreen
      
      # balance out tree of windows (resize to occupy same area)
      shift + alt - e : yabai -m space --balance
      
      # swap windows
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - h : yabai -m window --swap west
      shift + alt - l : yabai -m window --swap east
      
      # move windo and split
      ctrl + alt - j : yabai -m window --warp south
      ctrl + alt - k : yabai -m window --warp north
      ctrl + alt - h : yabai -m window --warp west
      ctrl + alt - l : yabai -m window --warp east
      
      # move window to display left and right
      shift + alt - s : yabai -m window --display west; yabai -m display --focus west;
      shift + alt - g : yabai -m window --display east; yabai -m display --focus east;
      
      #move window to prev and next space
      shift + alt - p : yabai -m window --space prev;
      shift + alt - n : yabai -m window --space next;
      
      # move window to space #
      shift + alt - 1 : yabai -m window --space 1;
      shift + alt - 2 : yabai -m window --space 2;
      shift + alt - 3 : yabai -m window --space 3;
      shift + alt - 4 : yabai -m window --space 4;
      shift + alt - 5 : yabai -m window --space 5;
      shift + alt - 6 : yabai -m window --space 6;
      shift + alt - 7 : yabai -m window --space 7;
      
      # stop/start/restart yabai
      ctrl + alt - q : yabai --stop-service
      ctrl + alt - s : yabai --start-service
      ctrl + alt - r : yabai --restart-service

      # launchctl kickstart -k gui/${UID}/org.nixos.yabai && launchctl kickstart -k gui/${UID}/org.nixos.skhd
     '';
  };
}



