{ lib, ... }:
let
  isDirectory = type: type == "directory";
  isDefault = path: path == "default.nix";
  endsWithNix = path: lib.strings.hasSuffix ".nix" path;
in
{
  homeConfig = import ./homeConfig.nix;
  nixosSystem = import ./nixosSystem.nix;
  darwinSystem = import ./darwinSystem.nix;
  colmenaSystem = import ./colmenaSystem.nix;
  generateSystem = import ./generateSystem.nix;

  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          path: kind: isDirectory kind || ((!isDefault path) && (endsWithNix path))
        ) (builtins.readDir path)
      )
    );

  generateSshHosts =
    hosts:
    lib.attrsets.foldlAttrs (
      acc: host: val:
      let
        user = lib.attrByPath [ "user" ] "dsn" val;
        port = lib.attrByPath [ "port" ] 22 val;
      in
      acc
      + ''
        Host ${host}
          HostName ${val.ip}
          Port ${toString port}
          User ${user}

      ''
    ) "" (lib.attrsets.filterAttrs (_: v: v ? ip) hosts);

  relativeToRoot = lib.path.append ../.;

  mergeAttrs = sets: builtins.foldl' (acc: set: (acc // set)) { } sets;
}
