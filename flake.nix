{
  description = "Nix configuration";

  inputs = {
    # nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    # nixos-generators.url = "github:nix-community/nixos-generators";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
    flake-checker.inputs.nixpkgs.follows = "nixpkgs-unstable";
    flake-checker.url = "github:DeterminateSystems/flake-checker";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    sops.inputs.nixpkgs.follows = "nixpkgs";
    sops.url = "github:Mic92/sops-nix";
  };
  outputs = inputs@{ self, nixpkgs, darwin, home-manager, deploy-rs, ... }:
    let
      aarch64-darwin = "aarch64-darwin";
      x86_64-linux = "x86_64-linux";
    in {

      homeConfigurations.silver = home-manager.lib.homeManagerConfiguration {
        modules = [ ../home.nix ];
        pkgs = import nixpkgs { system = aarch64-darwin; };
        extraSpecialArgs = { system = aarch64-darwin; };
      };

      homeConfigurations.grey = home-manager.lib.homeManagerConfiguration {
        modules = [ ../home.nix ];
        pkgs = import nixpkgs { system = x86_64-linux; };
        extraSpecialArgs = { system = x86_64-linux; };
      };

      darwinConfigurations.silver = darwin.lib.darwinSystem {
        modules = [ ./hosts/silver/configuration.nix ];
        specialArgs = { inherit inputs; };
        system = aarch64-darwin;
      };

      nixosConfigurations.grey = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/grey/configuration.nix ];
        specialArgs = { inherit inputs; };
        system = x86_64-linux;
      };

      deploy.nodes.grey = {
        hostname = "grey";
        fastConnection = true;
        profiles.system = {
          sshUser = "dsn";
          user = "dsn";
          path = deploy-rs.lib.x86_64-linux.activate.nixos
            self.nixosConfigurations.grey;
          remoteBuild = true;
        };
      };
    };
}
