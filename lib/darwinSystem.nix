{ inputs, host, genSpecialArgs, ... }:
let
  inherit (host) darwin-modules system;
  defaultModules = [
    ../modules/darwin
    ../modules/nixos/nix.nix
    ../modules/nixos/shells.nix
    ../modules/nixos/packages.nix
  ];
in inputs.darwin.lib.darwinSystem {
  inherit system;
  specialArgs = genSpecialArgs system;
  modules = defaultModules ++ darwin-modules;
}
