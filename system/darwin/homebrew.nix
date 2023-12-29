{ ... }: {

  homebrew = {

    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    taps = [
      "fujiapple852/trippy"
      # "homebrew/core"
      # "homebrew/cask"
      # "homebrew/cask-fonts"
    ];
    brews = [ "mas" "sstp-client" "trippy" "git-crypt" ];
    casks = [
      # "arc"
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
}
