{
  description = "Nix configs ";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.pkgs.follows = "pkgs";
    };
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ self, pkgs, home-manager }:
    let
      mkHomeConfiguration = args:
        home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          configuration = args.config;
          homeDirectory = "/home/dsn";
          username = "dsn";
          stateVersion = "22.05";
        };
      mkConfiguration = args:
        pkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = args.modules;
        };
      # overlays = [ neovim-nightly-overlay ];
    in {

      homeConfigurations.dsn =
        mkHomeConfiguration { config = import ./hosts/desktop/home.nix; };

      nixosConfigurations.test =
        mkConfiguration { modules = [ 
  	    ./hosts/test/configuration.nix
	    ./hosts/test/hardware-configuration.nix
	  ]; 
        };
    };
}
