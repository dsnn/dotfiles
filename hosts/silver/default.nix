{
  inputs,
  genSpecialArgs,
  ...
}:
let
  hostname = "silver";
  system = "aarch64-darwin";
in
{
  home = inputs.home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = (genSpecialArgs system) // {
      inherit hostname system;
    };
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = [
      ../../modules/home
      ./home-packages.nix
      ./home.nix
    ];
  };

  system = inputs.darwin.lib.darwinSystem {
    inherit system;
    specialArgs = genSpecialArgs system;
    modules = [
      ../../modules/darwin
      ../../modules/nixos/nix.nix
      ./configuration.nix
    ];
  };
}
