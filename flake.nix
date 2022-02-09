{
  description = "Nix configs ";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.pkgs.follows = "pkgs";
    };
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@{ self, pkgs, home-manager, neovim-nightly }:
    let
      overlays = [ neovim-nightly.overlay ];
      mkHomeConfiguration = args:
        home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          configuration = { pkgs, ... }: {
            imports = args.modules;
            nixpkgs.overlays = overlays;
          };
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
    in {

      homeConfigurations = {
        wsl = mkHomeConfiguration { modules = [ ./home/wsl.nix ]; };
        desktop = mkHomeConfiguration { modules = [ ./home/desktop.nix ]; };
      };

      nixosConfigurations = {
        desktop = mkConfiguration { modules = [ ./hosts/desktop.nix ]; };
        server = mkConfiguration { modules = [ ./hosts/server.nix ]; };
      };
    };
}
