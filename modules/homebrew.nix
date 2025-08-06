{
  flake.modules.darwin.homebrew = {

    environment.systemPath = [ "/opt/homebrew/bin" ];

    homebrew = {
      enable = true;
      onActivation = {
        cleanup = "uninstall";
        upgrade = true;
      };
      caskArgs = {
        no_quarantine = true;
      };
      global = {
        autoUpdate = true;
      };
      taps = [ ];
      brews = [ ];
      casks = [
        # "raycast"
        # "spotify"
        # "slack"
        # "zoom"
        # "obs"
      ];
    };
  };
}
