{ pkgs, inputs, ... }: {

  imports = [ ../../modules/darwin ];

  dotfiles.services = {
    yabai.enable = true;
    skhd.enable = true;
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.package = pkgs.nixUnstable;
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };

  environment.shells = with pkgs; [ bash zsh ];
  environment.loginShell = pkgs.zsh;
  environment.systemPackages = with pkgs; [ coreutils home-manager ];
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];

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

  homebrew.enable = true;
  homebrew.caskArgs.no_quarantine = true;
  homebrew.global.brewfile = true;
  homebrew.taps = [ "fujiapple852/trippy" ];
  homebrew.brews = [ "mas" "sstp-client" "trippy" "git-crypt" ];
}
