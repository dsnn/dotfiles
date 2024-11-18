{
  inputs,
  myvars,
  name,
  genSpecialArgs,
  ...
}:
let
  inherit (myvars.system) aarch64-darwin;
  defaultModules = [
    ../modules/sets/common.nix
    ../modules/darwin
  ];
in
inputs.darwin.lib.darwinSystem {
  system = aarch64-darwin;
  specialArgs = genSpecialArgs aarch64-darwin;
  modules = defaultModules ++ [ ../hosts/${name} ];
}
