{ ... }: {

  dsn = {
    common.enable = true;
    homebrew.enable = true;
    skhd.enable = true;
  };

  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];

  security.pam.enableSudoTouchIdAuth = true;

  users.users.dsn.home = "/Users/dsn";

  services.nix-daemon.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      # _HIHideMenuBar = true;
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

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}
