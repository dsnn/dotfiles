{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../system/common.nix
    ../../system/darwin/homebrew.nix
    ../../system/darwin/skhd.nix
    ../../system/darwin/yabai.nix
  ];

  mine.services = {
    skhd.enable = true;
    yabai.enable = true;
    homebrew.enable = true;
  };

  environment.loginShell = pkgs.zsh;
  environment.shells = with pkgs; [ bash zsh ];
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];

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

  users.users.dsn.home = "/Users/dsn";

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
}
