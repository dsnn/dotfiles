{
  flake.modules.homeManager.silver.home.homeDirectory = "/Users/dsn";

  flake.modules.darwin.silver = {
    networking = {
      hostName = "silver";
    };
    nixpkgs = {
      hostPlatform = "aarch64-darwin";
    };
    system = {
      system.stateVersion = 6;
      primaryUser = "dsn";
      defaults = {
        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          AppleShowAllExtensions = true;
          InitialKeyRepeat = 15;
          KeyRepeat = 2;
        };
        dock = {
          autohide = true;
          orientation = "bottom";
          show-recents = false;
        };
        finder = {
          AppleShowAllExtensions = true;
          _FXShowPosixPathInTitle = true;
        };
      };
    };
  };
}
