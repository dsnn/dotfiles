{ config, lib, ... }:
with lib;
let cfg = config.dsn.postgres;
in {
  options.dsn.postgres = { enable = mkEnableOption "Enable postgres"; };

  config = mkIf cfg.enable { services.postgresql = { enable = true; }; };
}
