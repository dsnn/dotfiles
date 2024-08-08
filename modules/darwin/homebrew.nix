{ lib, config, ... }:
with lib;
let cfg = config.dsn.homebrew;
in {
  options.dsn.homebrew = { enable = mkEnableOption "Enable homebrew"; };

  config = mkIf cfg.enable {
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
      brews = [ "mas" "sstp-client" "trippy" "git-crypt" ];
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
  };
}
