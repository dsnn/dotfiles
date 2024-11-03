{ inputs, unstable, ... }:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{
  mkHome =
    system: name:
    homeManagerConfiguration {
      extraSpecialArgs = {
        unstable = unstable system;
        inherit inputs;
        hostname = name;
      };
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      modules = [
        ../profiles/dsn.nix
        ../modules/home
        ../modules/scripts
      ];
    };
}
