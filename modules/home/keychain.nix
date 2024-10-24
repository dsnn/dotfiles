{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.keychain;
in
{

  options.dsn.keychain = {
    enable = mkEnableOption "Enable keychain";
  };

  config = mkIf cfg.enable {
    programs = {
      keychain = {
        enable = true;
        enableZshIntegration = true;
        extraFlags = [
          "--quiet"
          "--quick"
        ];
        agents = [ "ssh" ];
        keys = [ "id_rsa" ];
      };
    };
  };
}
