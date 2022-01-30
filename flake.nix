{
  description = "Nix configs ";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
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

    in {

      homeConfigurations.dsn =
        mkHomeConfiguration { config = import ./home.nix; };

    };
}
