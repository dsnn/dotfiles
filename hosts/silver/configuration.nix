{ ... }: {

  dsn = {
    nix.enable = true;
    shells.enable = true;
    systemPackages.enable = true;
    homebrew.enable = true;
    skhd.enable = true;
    terraform.enable = true;
  };

  time.timeZone = "Europe/Stockholm";

  security.pam.enableSudoTouchIdAuth = true;

  users.users.dsn.home = "/Users/dsn";

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  system.defaults = {
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

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}
