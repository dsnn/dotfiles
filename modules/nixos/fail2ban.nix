{
  config,
  lib,
  vars,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (vars.networking.fail2ban) ignoreIP maxretry;
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
