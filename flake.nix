{
  description = "Nix configs ";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.pkgs.follows = "pkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@{ self, pkgs, home-manager, sops-nix, neovim-nightly }:
    let
      overlays = [ neovim-nightly.overlay sops-nix ];
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
          modules = args.modules ++ [ sops-nix.nixosModules.sops ];
        };
    in {

      homeConfigurations = {
        wsl = mkHomeConfiguration { modules = [ ./home/wsl.nix ]; };
        desktop = mkHomeConfiguration { modules = [ ./home/desktop.nix ]; };
        laptop = mkHomeConfiguration { modules = [ ./home/laptop.nix ]; };
        server = mkHomeConfiguration { modules = [ ./home/server.nix ]; };
      };

      nixosConfigurations = {
        desktop = mkConfiguration { modules = [ ./hosts/desktop.nix ]; };
        laptop = mkConfiguration { modules = [ ./hosts/laptop.nix ]; };
        server = mkConfiguration { modules = [ ./hosts/server.nix ]; };
      };
    };
}
