{
  description = "Nix configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # NixPkgs (nixos-23.05)
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # NixPkgs Unstable (nixos-unstable)
    # unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS Support (master)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Secrets
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # sops-nix.url = "github:Mic92/sops-nix";

    # # Generate System Images
    # nixos-generators.url = "github:nix-community/nixos-generators";
    # nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # # System Deployment
    # deploy-rs.url = "github:serokell/deploy-rs";
    # deploy-rs.inputs.nixpkgs.follows = "unstable";

    # # Flake Hygiene
    # flake-checker = {
    #   url = "github:DeterminateSystems/flake-checker";
    #   inputs.nixpkgs.follows = "unstable";
    # };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }:
    let
      darwinSys = "aarch64-darwin";
      amdSys = "x86_64-linux";

      pkgsForSystem = system: import nixpkgs { inherit system; };

    in {

      homeConfigurations.macbook = home-manager.lib.homeManagerConfiguration {
        modules = [ ./hosts/macbook/home.nix ];
        pkgs = pkgsForSystem darwinSys;
      };

      homeConfigurations.alpha = home-manager.lib.homeManagerConfiguration {
        modules = [ ./hosts/desktop/home.nix ];
        pkgs = pkgsForSystem amdSys;
      };

      darwinConfigurations.macbook = darwin.lib.darwinSystem {
        system = darwinSys;
        pkgs = import nixpkgs { system = darwinSys; };
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/macbook/configuration.nix ];
      };

      nixosConfigurations.alpha = nixpkgs.lib.nixosSystem {
        system = amdSys;
        pkgs = import nixpkgs { system = amdSys; };
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/desktop/configuration.nix ];
      };
    };
}
