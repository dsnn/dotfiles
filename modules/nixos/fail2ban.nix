{ config, lib, ... }:
with lib;
let cfg = config.dsn.fail2ban;
in {
  options.dsn.fail2ban = { enable = mkEnableOption "Enable fail2ban"; };

  config = mkIf cfg.enable {
    services.fail2ban.enable = true;
    services.fail2ban.bantime-increment.enable = true;
    services.fail2ban.maxretry = 5;
  };
}
