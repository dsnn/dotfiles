{ config, pkgs, inputs, lib, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  home = if isDarwin then "/Users/dsn" else "/home/dsn";
  defaultSopsPath =
    "${toString inputs.self}/hosts/${config.networking.hostName}/secrets.yaml";
in {

  sops.age.keyFile = "${home}/.config/sops/age/keys.txt";

  sops.defaultSopsFile =
    lib.mkIf (builtins.pathExists defaultSopsPath) defaultSopsPath;
}
