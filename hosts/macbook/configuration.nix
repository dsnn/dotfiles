{ ... }: {

  imports = [
    ../../modules/system/environment.nix
    ../../modules/system/homebrew.nix
    ../../modules/system/nix-doc.nix
    # ../../modules/system/skhd.nix
    ../../modules/system/yabai.nix
  ];

  # dotfiles.services = {
  #   yabai.enable = true;
  #   skhd.enable = true;
  # };
  dotfiles.homebrew.enable = true;

  system.defaults = {
    # ".GlobalPreferences" = { "com.apple.mouse.scaling" = "1"; };
    # NSAutomaticCapitalizationEnabled = false;
    # NSAutomaticDashSubstitutionEnabled = false;
    # NSAutomaticPeriodSubstitutionEnabled = false;
    # NSAutomaticQuoteSubstitutionEnabled = false;
    # NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
  };

  # system.keyboard = {
  #   enableKeyMapping = true;
  #   remapCapsLockToEscape = true;
  # };

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;

  users.users.dsn.home = "/Users/dsn";

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  # homebrew.enable = true;
  # homebrew.caskArgs.no_quarantine = true;
  # homebrew.global.brewfile = true;
  # homebrew.taps = [ "fujiapple852/trippy" ];
  # homebrew.brews = [ "mas" "sstp-client" "trippy" "git-crypt" ];
}
