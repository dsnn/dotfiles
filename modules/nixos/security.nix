{
  config,
  lib,
  myvars,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (myvars) username;
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
