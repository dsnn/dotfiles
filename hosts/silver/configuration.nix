{ pkgs, ... }:
{

  dsn.nix.enable = true;

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    taps = [
      "fujiapple852/trippy" # access this by cmd "trip"
      # "homebrew/core"
      # "homebrew/cask"
      # "homebrew/cask-fonts"
    ];
    brews = [
      "mas"
      "sstp-client"
      "trippy"
      "git-crypt"
    ];
    casks = [
      # "raycast"
      # "firefox"
      # "spotify"
      # "slack"
      # "visual-studio-code"
      # "zoom"
      # "obs"
      # "font-sf-mono-nerd-font"
    ];
  };

  environment.systemPackages = with pkgs; [
    age
    coreutils
    file
    findutils
    git
    home-manager
    htop
    man
    nix
    tree
    vim
    which
  ];

  environment = {
    shells = with pkgs; [
      bash
      zsh
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  time.timeZone = "Europe/Stockholm";

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.dsn.home = "/Users/dsn";

  programs.zsh.enable = true;

  system = {
    primaryUser = "dsn";

    # Used for backwards compatibility, please read the changelog before changing.
    stateVersion = 4;
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
}
