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

  relativeToRoot = lib.path.append ../.;

  mergeAttrs = sets: builtins.foldl' (acc: set: (acc // set)) { } sets;
}
