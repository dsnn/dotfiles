{ pkgs, ... }: {

  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [
      pkgs.coreutils 
      pkgs.home-manager
      # pkgs.agenix.packages.aarch64-darwin.default
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  users.users.dsn.home = "/Users/dsn";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.package = pkgs.nixUnstable;
  nix.gc.automatic = true;
  # nix.gc.interval = "03:15";
  
  # replace duplicates w/ hard links (and save space)
  # settings.auto-optimise-store = true;
  
  # nixpkgs.config.allowUnfree = true;

  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;

  # fonts.fontDir.enable = true; # DANGER
  # fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    casks = [ 
      # "raycast" 
      # "font-fira-code-nerd-font"
      # "kitty"
      # "mos"
    ];
    # masApps = { };
    taps = [ 
      "fujiapple852/trippy" 
      # "1password/tap"
      # "hashicorp/tap"
      # "homebrew/bundle"
      #"homebrew/cask-fonts"
    ];
    brews = [ 
      "sstp-client"
      "trippy" # https://github.com/fujiapple852/trippy
       # "hashicorp/tap/packer"
    ];
  };
}
