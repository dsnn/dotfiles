{
  config,
  lib,
  myvars,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  ignoreIP = [
    "10.0.0.0/24"
    "192.168.0.0/24"
  ];
  maxretry = 5;
  cfg = config.dsn.fail2ban;
in
{
  options.dsn.fail2ban = {
    enable = mkEnableOption "Enable fail2ban";
  };

  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      bantime-increment.enable = true;
      inherit ignoreIP maxretry;
    };
  };
}
