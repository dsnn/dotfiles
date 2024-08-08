{ inputs, lib, config, pkgs, ... }:
let
  cfg = config.dsn.sops;
  inherit (pkgs.stdenv) isDarwin;
  home = if isDarwin then "/Users/dsn" else "/home/dsn";
in {

  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.dsn.sops = {
    enable = lib.mkEnableOption "Enable sops";
    path = lib.mkOption {
      type = lib.types.path;
      default = "${home}/.config/sops/age/keys.txt";
      description = "Path to the sops key file";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.age.keyFile = cfg.path;
    sops.age.sshKeyPaths = [ ];
  };
}
