{ config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.dsn.common;
in
{
  options.dsn.common = {
    enable = mkEnableOption "Enable users";
  };

  config = mkIf cfg.enable {
    dsn = {
      i18n.enable = true;
      nix.enable = true;
      systemPackages.enable = true;
      security.enable = true;
      shells.enable = true;
      openssh.enable = true;
      user.enable = true;
      sops.enable = true;
    };

    time.timeZone = "Europe/Stockholm";
  };
}
