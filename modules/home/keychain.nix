{ config, lib, ... }:
with lib;
let cfg = config.dsn.keychain;
in {

  options.dsn.keychain = { enable = mkEnableOption "Enable keychain"; };

  config = mkIf cfg.enable {
    programs.keychain.enable = true;
    programs.keychain.enableZshIntegration = true;
    programs.keychain.extraFlags = [ "--quiet" "--quick" ];
    programs.keychain.agents = [ "ssh" ];
    programs.keychain.keys = [ "id_rsa" ];
  };
}
