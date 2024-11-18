{
  inputs,
  myvars,
  name,
  genSpecialArgs,
  ...
}:
let
  inherit (myvars.system) x86_64-linux;
  defaultModules = [
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    ../modules/sets/common.nix
    ../modules/nixos
  ];
in
inputs.nixpkgs.lib.nixosSystem {
  system = x86_64-linux;
  specialArgs = genSpecialArgs x86_64-linux;
  modules = defaultModules ++ [ ../hosts/${name} ];
}
