{ config, lib, ... }:
with lib;
let
  cfg = config.dsn.prometheus;
in
{
  options.dsn.prometheus = {
    enable = mkEnableOption "Enable prometheus";
  };

  config = mkIf cfg.enable {

    services.prometheus.exporters.node = {
      enable = true;
      listenAddress = "0.0.0.0";
      port = 9100;
      enabledCollectors = [
        "systemd"
        "logind"
      ];
    };
  };
}
