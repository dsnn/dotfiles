{ lib, ... }:
{

  homeConfig = import ./homeConfig.nix;
  nixosSystem = import ./nixosSystem.nix;
  darwinSystem = import ./darwinSystem.nix;
  colmenaSystem = import ./colmenaSystem.nix;

  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
          (_type == "directory") # include directories
          || (
            (path != "default.nix") # ignore default.nix
            && (lib.strings.hasSuffix ".nix" path) # include .nix files
          )
        ) (builtins.readDir path)
      )
    );
}
