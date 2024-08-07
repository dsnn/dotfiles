{ config, lib, ... }:
with lib;
let cfg = config.dsn.k3s-server;
in {
  options.dsn.k3s-server = { enable = mkEnableOption "Enable k3s server"; };

  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "server";
      token = "<randomized common secret>";
      clusterInit = true;
    };
  };
}
