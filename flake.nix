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
      darwinSys = "aarch64-darwin";
      amdSys = "x86_64-linux";
      lib = import ./lib inputs;
    in with lib; {
      inherit lib;

      homeConfigurations.silver = mkHome { system = darwinSys; };
      homeConfigurations.grey = mkHome { system = amdSys; };

      darwinConfigurations.silver = darwin.lib.darwinSystem {
        modules = [ ./hosts/silver/configuration.nix ];
        specialArgs = { inherit inputs outputs; };
        system = darwinSys;
      };

      nixosConfigurations.grey = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/grey/configuration.nix ];
        specialArgs = { inherit inputs outputs; };
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
