{ config, lib, ... }:
with lib;
let cfg = config.dsn.zoxide;
in {

  options.dsn.zoxide = { enable = mkEnableOption "Enable zoxide"; };

  config = mkIf cfg.enable {
    programs.zoxide.enable = true;
    programs.zoxide.enableZshIntegration = true;
  };
}
