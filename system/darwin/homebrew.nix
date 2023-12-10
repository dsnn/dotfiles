{ lib, config, ... }:
with lib;
let cfg = config.mine.services.homebrew;
in {
  options.mine.services.homebrew = {
    enable = mkEnableOption "Enable homebrew";
  };

  config = mkIf cfg.enable {
    homebrew = {

      enable = true;
      caskArgs.no_quarantine = true;
      global.brewfile = true;
      taps = [ "fujiapple852/trippy" ];
      brews = [ "mas" "sstp-client" "trippy" "git-crypt" ];
      casks = [ "arc" ];
    };
  };
}
