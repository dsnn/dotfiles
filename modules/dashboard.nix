{
  flake.modules.services.homepage-dashboard = {
    services.homepage-dashboard = {
      enable = true;
      openFirewall = true;
      listenPort = 8082;
      settings = {
        theme = "dark";
      };
      services = [
        {
          "My First Group" = [
            {
              "My First Service" = {
                href = "http://localhost/";
                description = "Homepage is awesome";
              };
            }
          ];
        }
        {
          "My Second Group" = [
            {
              "My Second Service" = {
                href = "http://localhost/";
                description = "Homepage is the best";
              };
            }
          ];
        }
      ];
      bookmarks = [
        {
          Misc = [
            {
              Github = [
                {
                  abbr = "GH";
                  href = "https://github.com/";
                }
              ];
            }
          ];
        }
      ];
      widgets = [
        {
          resources = {
            cpu = true;
            memory = true;
            disk = "/";
            uptime = true;
          };
        }
        {
          search = {
            provider = "google";
            target = "_blank";
            showSearchSuggestions = true;
            focus = true;
          };
        }
        # { opnsense = { }; }
        # { gitea = { }; }
        # { unifi_console = { }; }
      ];
      # kubernetes = { };
      # docker = { };
    };

    # systemd.services.homepage-dashboard.environment.HOMEPAGE_CONFIG_DIR
    #   = lib.mkForce "/whatever/path/you/want";
  };
}
