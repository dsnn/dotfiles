{
  inputs,
  genSpecialArgs,
  host,
  ...
}:
let
  inherit (host) generate-modules system format;
  defaultModules = [
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    ../modules/nixos
  ];
in
inputs.nixos-generators.nixosGenerate {
  inherit system format;
  specialArgs = genSpecialArgs system;
  modules = generate-modules ++ defaultModules;
}
