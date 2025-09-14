{

  flake.modules.homeManager.hyprland = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # "killall -q swww;sleep .5 && swww-daemon"
        # "killall -q waybar;sleep .5 && waybar"
        # "killall -q swaync;sleep .5 && swaync"
        # "#wallsetter &"
        # "pypr &"
        # "nm-applet --indicator"
      ];
    };
  };
}
