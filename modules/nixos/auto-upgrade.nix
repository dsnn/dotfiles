{
  config,
  lib,
  vars,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (vars) version;
  cfg = config.dsn.autoUpgrade;
in
{
  options.dsn.autoUpgrade = {
    enable = mkEnableOption "Enable autoUpgrade";
  };

  config = mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-${version}";
      flags = [
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
      ];
      dates = "07:00";
    };
  };
}
