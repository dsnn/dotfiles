{ pkgs, ... }:
let mod = "Mod4";
in {

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = mod;

        # bars = [ ]; # use polybar instead

        gaps = {
          inner = 12;
          outer = 5;
          smartGaps = true;
          smartBorders = "off";
        };

        startup = [
          {
            command = "exec i3-msg workspace 1";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
          # {
          #   command = "systemctl --user restart polybar";
          #   always = true;
          #   notification = false;
          # }
          # { command = "exec firefox"; }
          # { command = "exec steam"; }
          # { command = "exec Discord"; }
          # { command = "xrand --output HDMI-0 --right-of DP-4"; notification = false; }
          # {
          #   command = "${pkgs.feh}/bin/feh --bg-scale ~/background.jpg";
          #   always = true;
          #   notification = false;
          # }
        ];

        keybindings = {
          "${mod}+f" = "fullscreen toggle";
          "${mod}+t" = "split toggle";
          "${mod}+Space" = "focus toggle_mode";

          "${mod}+q" = "kill";

          "${mod}+Shift+w" = "exec ${pkgs.firefox}/bin/firefox";
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

          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+e" = ''
            exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';
        };
      };
    };
  };

}
