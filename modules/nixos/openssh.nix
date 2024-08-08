{ config, lib, ... }:
with lib;
let cfg = config.dsn.openssh;
in {
  options.dsn.openssh = { enable = mkEnableOption "Enable ssh server"; };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      openFirewall = true;
      settings = {
        X11Forwarding = false;
        StrictModes = true;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        # KbdInteractiveAuthentication = false;
      };
      extraConfig = "\n";
    };
  };
}
