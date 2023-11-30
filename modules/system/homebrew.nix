{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.homebrew;
in {
  options.dotfiles.homebrew = {
    enable = mkEnableOption "Enable homebrew";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    homebrew.enable = true;
    homebrew.caskArgs.no_quarantine = true;
    homebrew.global.brewfile = true;
    homebrew.taps = [ "fujiapple852/trippy" ];
    homebrew.brews = [ "mas" "sstp-client" "trippy" "git-crypt" ];
  };
}
