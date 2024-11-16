{
  inputs,
  unstable,
  myvars,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs.darwin.lib) darwinSystem;
  inherit (myvars.system) x86_64-linux aarch64-darwin;
in
{
  mkNixos =
    host:
    nixosSystem {
      system = x86_64-linux;
      specialArgs = {
        unstable = unstable x86_64-linux;
        inherit inputs myvars;
      };
      modules = [
        inputs.disko.nixosModules.disko
        ../hosts/${host}
        ../modules/sets/common.nix
        ../modules/nixos
      ];
    };

  mkDarwin =
    host:
    darwinSystem {
      system = aarch64-darwin;
      specialArgs = {
        unstable = unstable aarch64-darwin;
        inherit inputs myvars;
      };
      modules = [
        ../hosts/${host}
        ../modules/sets/common.nix
        ../modules/darwin
      ];
    };
}
