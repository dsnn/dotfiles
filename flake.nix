{
  description = "Nix configs";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, pkgs, home-manager, ... }: {
    homeConfigurations = {
      dsn = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/dsn";
        username = "dsn";
        stateVersion = "22.05";
        configuration = import ./home.nix;
      };
    };

  };
}
