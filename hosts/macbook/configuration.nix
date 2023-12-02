{ ... }: {

  imports = [
    ../../modules/darwin/environment.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/nix.nix
    ../../modules/darwin/skhd.nix
    ../../modules/darwin/yabai.nix
  ];

  mine.services = {
    skhd.enable = true;
    yabai.enable = true;
    homebrew.enable = true;
  };

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
