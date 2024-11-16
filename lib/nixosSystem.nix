{
  inputs,
  unstable,
  myvars,
  name,
  ...
}:
let
  inherit (myvars.system) x86_64-linux;
  defaultModules = [
    inputs.disko.nixosModules.disko
    ../modules/sets/common.nix
    ../modules/nixos
  ];
in
inputs.nixpkgs.lib.nixosSystem {
  system = x86_64-linux;
  specialArgs = {
    unstable = unstable x86_64-linux;
    inherit inputs myvars;
  };
  modules = defaultModules ++ [ ../hosts/${name} ];
}
