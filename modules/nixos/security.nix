{ config, lib, ... }:
with lib;
let cfg = config.dsn.security;
in {

  options.dsn.security = { enable = mkEnableOption "Enable security"; };

  config = mkIf cfg.enable {
    security.sudo.extraRules = [{
      users = [ "dsn" ];
      commands = [{
        command = "ALL";
        options =
          [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
      }];
    }];
  };
}
