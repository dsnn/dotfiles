{
  inputs,
  host,
  genSpecialArgs,
  ...
}:
let
  inherit (host) nixos-modules system;
  defaultModules = [
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    ../modules/sets/common.nix
    ../modules/nixos
  ];
in
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = genSpecialArgs system;
  modules = nixos-modules ++ defaultModules;
}
