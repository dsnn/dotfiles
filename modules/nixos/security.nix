{
  config,
  lib,
  vars,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (vars) username;
  cfg = config.dsn.security;
in
{
  options.dsn.security = {
    enable = mkEnableOption "Enable security";
  };

  config = mkIf cfg.enable {
    security = {
      sudo = {
        wheelNeedsPassword = false;
        extraRules = [
          {
            users = [ username ];
            commands = [
              {
                command = "ALL";
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ];
      };
    };
  };
}
