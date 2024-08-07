{ config, pkgs, lib, ... }:
with lib;
let cfg = config.dsn.cups;
in {
  options.dsn.cups = { enable = mkEnableOption "Enable cups"; };

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
      drivers = with pkgs; [ cups-bjnp gutenprint ];
    };
  };
}
