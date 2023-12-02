{ lib, config, ... }:
with lib;
let cfg = config.mine.services.homebrew;
in {
  options.mine.services.homebrew = {
    enable = mkEnableOption "Enable homebrew";
  };

  config = mkIf cfg.enable {
    homebrew.enable = true;
    homebrew.caskArgs.no_quarantine = true;
    homebrew.global.brewfile = true;
    homebrew.taps = [ "fujiapple852/trippy" ];
    homebrew.brews = [ "mas" "sstp-client" "trippy" "git-crypt" ];
  };
}
