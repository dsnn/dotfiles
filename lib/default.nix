{ inputs, ... }:
let
  unstable =
    system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  vars = import ../variables { inherit inputs; };
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
  home = import ./home.nix { inherit inputs unstable vars; };
  system = import ./system.nix { inherit inputs unstable vars; };
  colmena = import ./colmena.nix {
    inherit
      inputs
      unstable
      vars
      scanPaths
      ;
  };
  generate = import ./generate.nix { inherit inputs unstable vars; };

}
