{
  inputs,
  unstable,
  vars,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs.darwin.lib) darwinSystem;
  inherit (vars.system) x86_64-linux aarch64-darwin;
in
{
  mkNixos =
    host:
    nixosSystem {
      system = x86_64-linux;
      specialArgs = {
        unstable = unstable x86_64-linux;
        inherit inputs vars;
      };
      modules = [
        inputs.disko.nixosModules.disko
        ../hosts/${host}
        ../modules/common.nix
        ../modules/nixos
      ];
    };

  mkDarwin =
    host:
    darwinSystem {
      system = aarch64-darwin;
      specialArgs = {
        unstable = unstable aarch64-darwin;
        inherit inputs vars;
      };
      modules = [
        ../hosts/${host}
        ../modules/common.nix
        ../modules/darwin
      ];
    };
}
