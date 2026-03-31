{
  flake.modules.homeManager.polybar =
    { config, pkgs, ... }:
    let
      polybarPkg = pkgs.polybarFull;
      colors = {
        black = "#263238";
        white = "#D8DEE9";
        red = "#BF616A";
        red1 = "#BF3B48";
        green = "#94AD7D";
        green1 = "#70AD37";
        blue = "#5E81AC";
        blue1 = "#3C6EAC";
        cyan = "#7AACBA";
        cyan1 = "#56A4BA";
        violet = "#B48EAD";
        violet1 = "#B46AA6";
        orange = "#D08770";
        orange1 = "#D06847";
        yellow = "#CFB074";
        yellow1 = "#CF9B36";
        focus = "#8C8C8C";
        focus1 = "#757575";
        unfocus = "#1A2328";
        unfocus1 = "#101010";
      };
    in
    {
      home.packages = with pkgs; [
        gsimplecal # simple calendar for polybar
      ];

      # disable i3's own status bar
      xsession.windowManager.i3.config.bars = [ ];
      xsession.windowManager.i3.config.startup = [
        {
          command = "systemctl --user restart polybar";
          always = true;
        }
      ];

      systemd.user.services.polybar.Service = {
        Environment = [
          "DISPLAY=:10"
          "XAUTHORITY=%h/.Xauthority"
        ];
      };

      services.polybar.enable = true;
      services.polybar.package = polybarPkg;
      services.polybar.script = ''
        if command -v ${pkgs.xorg.xrandr}/bin/xrandr >/dev/null; then
          MONITORS=$(${pkgs.xorg.xrandr}/bin/xrandr --query | \
            ${pkgs.gnugrep}/bin/grep " connected" | \
            ${pkgs.coreutils}/bin/cut -d" " -f1)
        else
          MONITORS=""
        fi

        if [ -z "$MONITORS" ]; then
          MONITORS="default"
        fi

        for MONITOR in $MONITORS; do
          # MONITOR=$MONITOR ${polybarPkg}/bin/polybar mybar &
          MONITOR=$MONITOR ${polybarPkg}/bin/polybar mybar >/dev/null 2>&1 &
        done
      '';
      services.polybar.config = {
        "bar/mybar" = {
          width = "100%";
          height = 24;
          bottom = true;
          background = colors.black;
          foreground = colors.white;

          border-size = 0;
          padding-left = 0;
          padding-right = 0;

          module-margin-left = 0;
          module-margin-right = 1;

          monitor = "\${env:MONITOR}";
          enable-ipc = true;

          font-0 = "MesloLGL Nerd Font:weight=bold:size=11;2";
          font-1 = "Fira Code Nerd Font:weight=bold:size=11";
          font-2 = "Noto Sans:size=11";

          modules-left = "i3";
          modules-right = "lan cpu memory sound storage battery date powermenu";
        };

        "module/i3" = {
          type = "internal/i3";
          index-sort = true;
          pin-workspaces = true;

          label-focused = "%index%";
          label-focused-background = colors.focus;
          label-focused-foreground = colors.black;
          label-focused-underline = colors.focus1;
          label-focused-padding = 2;

          label-unfocused = "%index%";
          label-unfocused-padding = 2;
          label-unfocused-background = colors.unfocus;
          label-unfocused-underline = colors.unfocus1;

          label-visible = "%index%";
          label-visible-background = colors.focus;
          label-visible-underline = colors.focus1;
          label-visible-padding = 2;

          label-urgent = "%index%";
          label-urgent-background = "#5f5f5f";
          label-urgent-padding = 2;
        };

        "module/lan" = {
          type = "internal/network";
          interface = "eth0"; # CHANGE THIS
          accumulate-stats = true;

          format-connected = "<ramp-signal> <label-connected>";
          label-connected = "  %downspeed% %local_ip%";
          format-connected-background = colors.violet;
          format-connected-foreground = colors.black;

          label-disconnected = "";
          format-disconnected-background = colors.red;
          format-disconnected-foreground = colors.black;
        };

        "module/storage" = {
          type = "internal/fs";
          mount-0 = "/";
          interval = 20;

          label-mounted = "  %free% ";
          format-mounted-background = colors.orange;
          format-mounted-foreground = colors.black;
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;

          label = " ﬙ %percentage:2%% ";
          format-background = colors.cyan;
          format-foreground = colors.black;
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 3;

          label = "  %gb_used% ";
          format-background = colors.green;
          format-foreground = colors.black;
        };

        "module/sound" = {
          type = "internal/pulseaudio";
          interval = 1;

          label-volume = "%percentage% ";
          format-volume = "<ramp-volume><label-volume>";

          format-volume-background = colors.yellow;
          format-volume-foreground = colors.black;

          label-muted = " 婢 mute ";
          label-muted-background = colors.yellow;
          label-muted-foreground = colors.black;
        };

        "module/battery" = {
          type = "internal/battery";
          battery = "BAT0";
          adapter = "ADP1";

          label-charging = "  %percentage%% ";
          label-discharging = "  %percentage%% ";
          label-full = "  %percentage%% ";

          format-charging-background = colors.red;
          format-discharging-background = colors.red;
          format-full-background = colors.red;
        };

        "module/date" = {
          type = "internal/date";
          interval = 1;

          date = "%Y-%m-%d";
          time = "%H:%M";

          label = " %date%   %time%";
          format-background = colors.black;
          format-foreground = colors.white;
        };

        "module/powermenu" = {
          type = "custom/menu";

          label-open = "  ";
          label-close = "  Abort ";

          menu-0-0 = "  Shutdown ";
          menu-0-0-exec = "systemctl poweroff";

          menu-0-1 = "  Reboot ";
          menu-0-1-exec = "systemctl reboot";
        };
      };
    };
}
