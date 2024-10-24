{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dsn.sops;
in
{

  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  options.dsn.sops = {
    enable = mkEnableOption "Enable sops";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.sops ];
    sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
