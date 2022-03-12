{ pkgs, ... }:
let mod = "Mod4";
in {

  # polybar
  services.polybar.enable = true;
  services.polybar.package = pkgs.polybarFull;
  services.polybar.config = pkgs.substituteAll {
    src = ./polybar-config;
    interface = "enp6s0";
  };
  services.polybar.script = ''
    for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
      MONITOR=$m polybar mybar &
    done
  '';

  # xsession
  xsession.enable = true;

  # i3
  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config.modifier = mod;
  xsession.windowManager.i3.config.bars = [ ];

  # i3 startup
  xsession.windowManager.i3.config.startup = [
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
  ];

  # i3 config
  xsession.windowManager.i3.config.keybindings = {
    "${mod}+f" = "fullscreen toggle";
    "${mod}+t" = "split toggle";
    "${mod}+Space" = "focus toggle_mode";
    "${mod}+Shift+f" = "floating toggle";

    "${mod}+q" = "kill";

    "${mod}+Shift+w" = "exec ${pkgs.firefox}/bin/firefox";
    "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
    "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
    "${mod}+m" = "exec spotify";

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

}
