{ nixpkgs, darwin, home-manager, ... }:
let
  darwinSys = "aarch64-darwin";
  # amdSys = "x86_64-linux";
  get-system-config = system:
    if system == darwinSys then
      darwin.lib.darwinSystem
    else
      nixpkgs.lib.nixosSystem;
  # load-home-modules = builtins.readFile./modules/home/default.nix;
  # load-system-modules = builtins.readFile./modules/system/default.nix;
in {
  mkHome = inputs@{ system, ... }:
    home-manager.lib.homeManagerConfiguration {
      modules = [ ../home.nix ];
      pkgs = import nixpkgs { inherit system; };
      extraSpecialArgs = { inherit inputs; };
    };

  mkConfig = inputs@{ system, modules, ... }:
    get-system-config system {
      pkgs = import nixpkgs { inherit system; };
      specialArgs = { inherit inputs; };
      inherit modules system;
    };
}

