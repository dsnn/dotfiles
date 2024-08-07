{ config, lib, ... }:
with lib;
let cfg = config.dsn.fail2ban;
in {
  options.dsn.fail2ban = { enable = mkEnableOption "Enable fail2ban"; };

  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      bantime-increment.enable = true;
      maxretry = 5;
      ignoreIP = [ "10.0.0.0/24" "192.168.0.0/24" ];
    };
  };
}
