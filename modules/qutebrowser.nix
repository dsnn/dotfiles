{

  flake.modules.homeManager.qutebrowser =
    { ... }:
    {
      programs.qutebrowser = {
        enable = true;
        enableDefaultBindings = true;

        searchEngines = {
          # DEFAULT = "https://duckduckgo.com/?q={}";
          DEFAULT = "https://www.google.com/search?hl=en&q={}";
          nixpkgs = "https://search.nixos.org/packages?channel=25.11&query={}";
          hm = "https://home-manager-options.extranix.com/?query={}";
        };

        quickmarks = {
          g = "https://github.com";
          n = "https://search.nixos.org/packages";
          h = "https://home-manager-options.extranix.com/";
          y = "https://youtube.com";
          r = "https://reddit.com";
        };

        # quickmarks = {
        #   hm = "https://home-manager-options.extranix.com";
        #   nixos = "https://search.nixos.org";
        # };

        keyBindings.normal = {
          # Quick search
          "sn" = "open -t https://search.nixos.org/packages?channel=25.11";
          "sh" = "open -t https://home-manager-options.extranix.com/";
          "sg" = "open -t https://google.com/";
          "sy" = "open -t https://youtube.com";
          "sr" = "open -t https://reddit.com";
          "wo" = "set-cmd-text -s :open -t";

          # Tabs␍
          "H" = "back";
          "L" = "forward";

          # Quick tab navigation␍
          "<Ctrl-h>" = "tab-prev";
          "<Ctrl-l>" = "tab-next";

          # Duplicate tab␍
          "yy" = "yank url";
          "pp" = "open -t {clipboard}";

          # Close tab␍
          "x" = "tab-close";

          # Reopen closed tab␍
          "u" = "undo";

          # Reload without cache␍
          "R" = "reload -f";

          # Open config quickly␍
          "gc" = "config-source";

          # Devtools (för frontend)␍
          "gi" = "inspector";

          # Downloads␍
          "gd" = "download";

          # Toggle UI
          "tb" = "config-cycle statusbar.show in-mode always;; config-cycle tabs.show never always";

          # Copy / pase flow
          "yc" = "yank selection";
          "pP" = "open {clipboard}";

          # Toggle darkmode
          "td" = "config-cycle colors.webpage.darkmode.enabled true false";

          # Zoom controls
          "+" = "zoom-in";
          "-" = "zoom-out";
          "=" = "zoom";

        };

        # Use tabs
        settings.tabs.tabs_are_windows = false;

        # Hide scrollbars
        settings.scrolling.bar = "never";

        # Minimal UI
        settings.tabs.show = "never";
        settings.statusbar.show = "in-mode";

        # Less visual noise␍
        settings.completion.shrink = true;

        # Faster scrolling␍
        settings.scrolling.smooth = false;

        # Less delay
        settings.input.insert_mode.auto_load = true;

        # Completion organization.
        settings.completion.open_categories = [
          "searchengines"
          "quickmarks"
          "bookmarks"
          "history"
        ];

        # Remove distractions
        settings.content.autoplay = false;
        settings.content.notifications.enabled = false;

        settings.colors = {
          hints.bg = "#000000";
          hints.fg = "#ffffff";
          tabs.bar.bg = "#000000";

          # Force dark mode
          webpage.darkmode.enabled = true;
          webpage.darkmode.policy.images = "never";
          webpage.bg = "black";

          # Completion / command bar styling
          completion.fg = "#ffffff";
          completion.odd.bg = "#111111";
          completion.even.bg = "#111111";
          completion.category.bg = "#000000";
          completion.category.fg = "#888888";

          # Active row
          completion.item.selected.bg = "#66bb6a";
          completion.item.selected.fg = "#000000";
          completion.item.selected.border.top = "#1b5e20";
          completion.item.selected.border.bottom = "#1b5e20";

          # Remove borders / bars
          completion.category.border.top = "black";
          completion.category.border.bottom = "black";

          # Command bar
          statusbar.normal.bg = "#000000";
          statusbar.command.bg = "#000000";
          statusbar.insert.bg = "#000000";

          # Prompt (:/)
          prompts.bg = "#000000";
          prompts.fg = "#ffffff";
        };
      };
    };
}
