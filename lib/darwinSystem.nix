{
  inputs,
  host,
  genSpecialArgs,
  ...
}:
let
  inherit (host) darwin-modules system;
  defaultModules = [
    ../modules/sets/common.nix
    ../modules/darwin
  ];
in
inputs.darwin.lib.darwinSystem {
  inherit system;
  specialArgs = genSpecialArgs system;
  modules = defaultModules ++ darwin-modules;
}
