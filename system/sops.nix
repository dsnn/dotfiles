{ config, inputs, lib, ... }:
let
  defaultSopsPath =
    "${toString inputs.self}/hosts/${config.networking.hostName}/secrets.yaml";
in {

  sops.age.keyFile = "/home/dsn/.config/sops/age/keys.txt";

  sops.defaultSopsFile =
    lib.mkIf (builtins.pathExists defaultSopsPath) defaultSopsPath;
}
