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
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;

  users.users.dsn.home = "/Users/dsn";

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
}
