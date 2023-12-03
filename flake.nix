{
  description = "Nix configuration";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # NixPkgs (nixos-23.05)
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # NixPkgs Unstable (nixos-unstable)
    # unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS Support (master)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Secrets
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

    # # Generate System Images
    # nixos-generators.url = "github:nix-community/nixos-generators";
    # nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # System Deployment
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Flake Hygiene
    flake-checker = {
      url = "github:DeterminateSystems/flake-checker";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, deploy-rs, ... }:
    let
      darwinSys = "aarch64-darwin";
      amdSys = "x86_64-linux";
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      lib = import ./lib inputs;
    in with lib; {
      inherit lib;

      homeConfigurations.silver = mkHome { system = darwinSys; };
      homeConfigurations.grey = mkHome { system = amdSys; };

      darwinConfigurations.silver = mkConfig {
        system = darwinSys;
        modules = [ ./hosts/silver/configuration.nix ];
      };

      nixosConfigurations.grey = mkConfig {
        system = "x86_64-linux";
        modules = [ ./hosts/grey/configuration.nix ];
      };

      deploy.nodes = {
        grey = {
          # sshOpts = [ "-p" "2221" ];
          hostname = "grey";
          fastConnection = true;
          profiles.system = {
            user = "dsn";
            path = deploy-rs.lib.x86_64-linux.activate.nixos
              self.nixosConfigurations.grey;
            remoteBuild = true;
          };
        };
      };

      devShells.${amdSys} = pkgs.mkShell {
        buildInputs = [ pkgs.deploy-rs ];
        inputsFrom = [ ];
      };

      # darwinConfigurations = {
      #   macbook = darwin.lib.darwinSystem {
      #     system = darwinSys;
      #     pkgs = import nixpkgs { system = darwinSys; };
      #     specialArgs = { inherit inputs; };
      #   };
      # };

      # nixosConfigurations = {
      #   alpha = nixpkgs.lib.nixosSystem {
      #     system = amdSys;
      #     pkgs = import nixpkgs { system = amdSys; };
      #     specialArgs = { inherit inputs; };
      #     modules = [ ./hosts/desktop/configuration.nix ];
      #   };
      # };
    };
}
