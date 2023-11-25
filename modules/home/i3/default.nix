{ config, pkgs, ... }:
let mod = "Mod4";
in {

  # reference
  # https://github.com/nix-community/home-manager/blob/master/modules/services/window-managers/i3-sway/i3.nix
  # https://github.com/nix-community/home-manager/blob/master/modules/services/window-managers/i3-sway/lib/options.nix

  # install i3 deps
  home.packages = with pkgs; [ xorg.xbacklight pavucontrol ];

  # xsession
  xsession.enable = true;

  # cursor
  home.pointerCursor.package = pkgs.nordzy-cursor-theme;
  home.pointerCursor.name = "Nordzy-cursors";

  # i3
  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config.modifier = mod;
  xsession.windowManager.i3.config.bars = [ ];

  # i3 startup
  xsession.windowManager.i3.config.startup = [
    # { command = "exec firefox"; }
    # { command = "exec Discord"; }
    {
      # xrandr --output X --primary
      command = "exec i3-msg workspace 1";
      always = true;
      notification = false;
    }
    {
      command = "/home/dsn/.config/polybar/launch.sh";
      always = true;
      notification = false;
    }
  ];
  # xsession.windowManager.i3.config.assigns = {
  #   "1" = [{ class = "^Firefox$"; }];
  #   "3" = [{ class = "^Discord$"; }];
  # };

  # no title bar
  xsession.windowManager.i3.config.window.titlebar = false;

  # window commands
  # xsession.windowManager.i3.config.window.commands = [{
  #   command = "border pixel 1";
  #   critera = { class = "^.*"; };
  # }];

  # i3 keybindings
  xsession.windowManager.i3.config.keybindings = {
    "${mod}+f" = "fullscreen toggle";
    "${mod}+t" = "split toggle";
    "${mod}+Space" = "focus toggle_mode";
    "${mod}+Shift+f" = "floating toggle";

    "${mod}+q" = "kill";

    "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
    "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";

    "${mod}+h" = "focus left";
    "${mod}+j" = "focus down";
    "${mod}+k" = "focus up";
    "${mod}+l" = "focus right";

    "${mod}+Shift+h" = "move left 30";
    "${mod}+Shift+j" = "move down 30";
    "${mod}+Shift+k" = "move up 30";
    "${mod}+Shift+l" = "move right 30";

    "${mod}+Tab" = "workspace back_and_forth";
    "${mod}+Shift+Tab" = "workspace prev";

    "${mod}+1" = "workspace 1";
    "${mod}+2" = "workspace 2";
    "${mod}+3" = "workspace 3";
    "${mod}+4" = "workspace 4";
    "${mod}+5" = "workspace 5";
    "${mod}+6" = "workspace 6";
    "${mod}+7" = "workspace 7";
    "${mod}+8" = "workspace 8";
    "${mod}+9" = "workspace 9";
    "${mod}+0" = "workspace 10";

    "${mod}+Shift+1" = "move container to workspace 1";
    "${mod}+Shift+2" = "move container to workspace 2";
    "${mod}+Shift+3" = "move container to workspace 3";
    "${mod}+Shift+4" = "move container to workspace 4";
    "${mod}+Shift+5" = "move container to workspace 5";
    "${mod}+Shift+6" = "move container to workspace 6";
    "${mod}+Shift+7" = "move container to workspace 7";
    "${mod}+Shift+8" = "move container to workspace 8";
    "${mod}+Shift+9" = "move container to workspace 9";
    "${mod}+Shift+0" = "move container to workspace 10";

    # multimedia keys
    #bindsym XF86AudioPlay  exec "mpc toggle"
    #bindsym XF86AudioStop  exec "mpc stop"
    #bindsym XF86AudioNext  exec "mpc next"
    #bindsym XF86AudioPrev  exec "mpc prev"
    #bindsym XF86AudioPause exec "mpc pause"

    # pulse audio controls
    "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer --increase 5";
    "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer --decrease 5";
    "XF86AudioMute" = "exec ${pkgs.pamixer} --toggle-mute";

    # sreen brightness controls
    # "XF86MonBrightnessUp" =
    #   "exec ${pkgs.brightnessctl}/bin/brightnessctl set +2%";
    # "XF86MonBrightnessDown" =
    #   "exec ${pkgs.brightnessctl}/bin/brightnessctl set 2%-";

    "${mod}+Shift+r" = "restart";
    "${mod}+Shift+e" = ''
      exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';
  };

  xsession.windowManager.i3.extraConfig = ''
    for_window [window_type="dialog"] floating enable
    for_window [window_type="utility"] floating enable
    for_window [window_type="toolbar"] floating enable
    for_window [window_type="splash"] floating enable
    for_window [window_type="menu"] floating enable
    for_window [window_type="dropdown_menu"] floating enable
    for_window [window_type="popup_menu"] floating enable
    for_window [window_type="tooltip"] floating enable
    for_window [window_type="notification"] floating enable
  '';

}
