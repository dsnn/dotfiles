{
  inputs,
  genSpecialArgs,
  systems,
  ...
}:
let
  hostname = "silver";
  system = systems.aarch64-darwin;
in
{
  home = inputs.home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = (genSpecialArgs system) // {
      inherit hostname system;
    };
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = [
      ../modules
      ./home-packages.nix
      ./home.nix
    ];
  };

  system = inputs.darwin.lib.darwinSystem {
    inherit system;
    specialArgs = genSpecialArgs system;
    modules = [
      ../modules/nix.nix
      ./configuration.nix
    ];
  };
}
