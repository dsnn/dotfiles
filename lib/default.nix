{ inputs, ... }:
let
  unstable =
    system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  myvars = import ../variables { inherit inputs; };
  lib = inputs.nixpkgs.lib;
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
in
{
  home = import ./home.nix { inherit inputs unstable myvars; };
  system = import ./system.nix { inherit inputs unstable myvars; };
  colmena = import ./colmena.nix {
    inherit
      inputs
      unstable
      myvars
      scanPaths
      ;
  };
  generate = import ./generate.nix { inherit inputs unstable myvars; };

}
