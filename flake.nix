{
  description = "Nix configs";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    # let mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration {
    #     system = args.system or "x86_64-linux";
    #     # configuration = import ./home.nix;
    #     homeDirectory = "/home/dsn";
    #     username = "dsn";
    #     stateVersion = "22.05";
    #   };
    {

      homeConfigurations = {
        dsn = inputs.home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          homeDirectory = "/home/dsn";
          username = "dsn";
          stateVersion = "22.05";
          configuration = { config, pkgs, lib, ... }: {
            imports = [ ./home.nix ];
          };
        };
      };

      dsn = self.homeConfigurations.dsn.activationPackage;
      defaultPackage.x86_64-linux = self.dsn;

      # homeConfigurations.dsn = mkHomeConfiguration {
      #     system = "x86_64-linux";
      #     homeDirectory = "/home/dsn";
      #     username = "dsn";
      #     configuration = { config, pkgs, ...}: {
      #       imports = [ ./home.nix ];
      #     };
      #     stateVersion = "22.05";
      # };

      # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      # defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
    };
}
