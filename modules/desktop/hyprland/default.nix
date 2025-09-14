{

  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      systemd.user.targets.hyprland-session.Unit.Wants = [
        "xdg-desktop-autostart.target"
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland;
        xwayland.enable = true;

        systemd = {
          enable = true;
          enableXdgAutostart = true;
          variables = [ "--all" ];
        };

        settings = {
          input = {
            kb_layout = "us";
            kb_options = [
              "grp:alt_caps_toggle"
              "caps:super"
            ];
            numlock_by_default = true;
            repeat_delay = 300;
            follow_mouse = 1;
            float_switch_override_focus = 0;
            sensitivity = 0;
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
              scroll_factor = 0.8;
            };
          };

          gestures = {
            workspace_swipe = 1;
            workspace_swipe_fingers = 3;
            workspace_swipe_distance = 500;
            workspace_swipe_invert = 1;
            workspace_swipe_min_speed_to_force = 30;
            workspace_swipe_cancel_ratio = 0.5;
            workspace_swipe_create_new = 1;
            workspace_swipe_forever = 1;
          };

          general = {
            "$modifier" = "SUPER";
            layout = "dwindle";
            gaps_in = 6;
            gaps_out = 8;
            border_size = 2;
            resize_on_border = true;
            # "col.active_border" =
            #   "rgb(${config.lib.stylix.colors.base08}) rgb(${config.lib.stylix.colors.base0C}) 45deg";
            # "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";
          };

          misc = {
            layers_hog_keyboard_focus = true;
            initial_workspace_tracking = 0;
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = false;
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            enable_swallow = false;
            vfr = true; # Variable Frame Rate
            vrr = 2; # Variable Refresh Rate  Might need to set to 0 for NVIDIA/AQ_DRM_DEVICES
            # Screen flashing to black momentarily or going black when app is fullscreen
            # Try setting vrr to 0

            #  Application not responding (ANR) settings
            enable_anr_dialog = true;
            anr_missed_pings = 15;
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
            force_split = 2;
          };

          decoration = {
            rounding = 10;
            blur = {
              enabled = true;
              size = 5;
              passes = 3;
              ignore_opacity = false;
              new_optimizations = true;
            };
            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
              color = "rgba(1a1a1aee)";
            };
          };

          ecosystem = {
            no_donation_nag = true;
            no_update_news = false;
          };

          cursor = {
            sync_gsettings_theme = true;
            no_hardware_cursors = 2; # change to 1 if want to disable
            enable_hyprcursor = false;
            warp_on_change_workspace = 2;
            no_warps = true;
          };

          render = {
            # Disabling as no longer supported
            #explicit_sync = 1; # Change to 1 to disable
            #explicit_sync_kms = 1;
            direct_scanout = 0;
          };

          master = {
            new_status = "master";
            new_on_top = 1;
            mfact = 0.5;
          };

          # Ensure Xwayland windows render at integer scale; compositor scales them
          xwayland = {
            force_zero_scaling = true;
          };
        };

        extraConfig = "
          monitor=,preferred,auto,auto
        ";
      };
    };

  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      programs = {
        hyprland = {
          enable = true;
          xwayland.enable = true;
        };

        waybar.enable = true;
        hyprlock.enable = true;
        nm-applet.indicator = true;
      };

      xdg.portal = {
        enable = true;
        wlr.enable = false;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
        ];
        configPackages = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal
        ];
      };

      # for electron apps to use wayland
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      services.displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      hardware = {
        nvidia.modesetting.enable = true;
        graphics = {
          enable = true;
          extraPackages = with pkgs; [
            intel-media-driver
            libvdpau-va-gl
            libva
            libva-utils
          ];
        };
      };
    };
}

# set no update news

# wayland.windowManager.hyprland.plugins = [
#   # pkgs.hyprlandPlugins.<plugin>
# ];

# nix.settings = {
#   substituters = [ "https://hyprland.cachix.org" ];
#   trusted-substituters = [ "https://hyprland.cachix.org" ];
#   trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
# };
