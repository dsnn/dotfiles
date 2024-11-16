{
  inputs,
  unstable,
  myvars,
  name,
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
  specialArgs = {
    unstable = unstable aarch64-darwin;
    inherit inputs myvars;
  };
  modules = defaultModules ++ [ ../hosts/${name} ];
}
