{

  flake.modules.homeManager.qutebrowser =
    { ... }:
    {
      programs.qutebrowser = {
        enable = true;
        enableDefaultBindings = true;
        searchEngines = {

          w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
          aw = "https://wiki.archlinux.org/?search={}";
          nw = "https://wiki.nixos.org/index.php?search={}";
          g = "https://www.google.com/search?hl=en&q={}";
        };
        settings = {
          colors = {
            hints = {
              bg = "#000000";
              fg = "#ffffff";
            };
            tabs.bar.bg = "#000000";
          };
          tabs.tabs_are_windows = true;
        };
      };
    };
}
