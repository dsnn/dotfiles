{ config, lib, ... }:
with lib;
let cfg = config.dsn.avahi;
in {
  options.dsn.avahi = { enable = mkEnableOption "Enable avahi"; };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };
}
