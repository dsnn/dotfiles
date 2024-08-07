{ config, pkgs, lib, ... }:
with lib;
let cfg = config.dsn.k3s-agent;
in {
  options.dsn.k3s-agent = { enable = mkEnableOption "Enable k3s agent"; };

  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "agent";
      token = "<randomized common secret>";
      serverAddr = "https://<ip of first node>:6443";
    };
  };
}
