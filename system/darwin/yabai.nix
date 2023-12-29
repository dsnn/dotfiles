{ ... }: {

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse = "off";
      mouse_follows_focus = "off";
      window_placement = "second_child";
      window_opacity = "off";
      window_opacity_duration = "0.0";
      window_border = "on";
      window_border_placement = "inset";
      window_border_width = 2;
      window_border_radius = 3;
      active_window_border_topmost = "off";
      window_topmost = "on";
      window_shadow = "float";
      active_window_border_color = "0xff5c7e81";
      normal_window_border_color = "0xff505050";
      insert_window_border_color = "0xffd75f5f";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      split_ratio = "0.50";
      auto_balance = "on";
      mouse_modifier = "alt";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 5;
      bottom_padding = 5;
      left_padding = 5;
      right_padding = 5;
      window_gap = 5;
    };

    extraConfig = ''
      # center mouse on window with focus
      yabai -m config mouse_follows_focus on

      # when window is dropped in center of another window, swap them (on edges it will split it)
      yabai -m mouse_drop_action swap

      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^Calculator$" manage=off
      yabai -m rule --add app="^Karabiner-Elements$" manage=off

      yabai -m rule --add app="^Finder$" manage=off
      yabai -m rule --add app="^Safari$"  manage=off
      yabai -m rule --add app="^App Store$" manage=off
      yabai -m rule --add app="^Activity Monitor$" manage=off
      yabai -m rule --add app="^Dictionary$" manage=off
      yabai -m rule --add label="Software Update" manage=off
      yabai -m rule --add app="System Information" manage=off

      # TODO: review
      # yabai -m rule --add label="System Preferences" app="^System Preferences$" title=".*" manage=off
      # yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      # yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
    '';
  };
}

