{
  inputs,
  genSpecialArgs,
  host,
  ...
}:
let
  inherit (host) nixos-modules system format;
  defaultModules = [
    # inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    ../modules/sets/common.nix
    ../modules/nixos
  ];
in
inputs.nixos-generators.nixosGenerate {
  inherit system format;
  specialArgs = genSpecialArgs system.x86_64-linux;
  modules = nixos-modules ++ defaultModules;
}