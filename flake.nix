{
  description = "My dotfiles and infrastructure";

  inputs = {
    colmena.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    flake-checker.inputs.nixpkgs.follows = "nixpkgs-unstable";
    flake-checker.url = "github:DeterminateSystems/flake-checker";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    nix-ld.url = "github:Mic92/nix-ld";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    terranix.inputs.nixpkgs.follows = "nixpkgs";
    terranix.url = "github:terranix/terranix";
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{ self, ... }:
    let
      inherit (self) outputs;
      aarch64-darwin = "aarch64-darwin";
      x86_64-linux = "x86_64-linux";
      inherit (inputs.nixpkgs.lib) nixosSystem; # mapAttrs;
      inherit (inputs.darwin.lib) darwinSystem;
      inherit (inputs.home-manager.lib) homeManagerConfiguration;
      unstable =
        system:
        import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
    in
    {

      homeConfigurations = {
        silver = homeManagerConfiguration {
          extraSpecialArgs = {
            unstable = unstable aarch64-darwin;
            inherit inputs outputs;
            hostname = "silver";
          };
          pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./profiles/dsn.nix
            ./modules/home
            ./modules/scripts
          ];
        };

        dev = homeManagerConfiguration {
          extraSpecialArgs = {
            unstable = unstable x86_64-linux;
            inherit inputs outputs;
            hostname = "dev";
          };
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./profiles/dsn.nix
            ./modules/home
          ];
        };
      };

      darwinConfigurations.silver = darwinSystem {
        system = aarch64-darwin;
        specialArgs = {
          unstable = unstable aarch64-darwin;
          inherit inputs outputs;
        };
        modules = [
          ./configs/silver.nix
          ./modules/common.nix
          ./modules/darwin
        ];
      };

      nixosConfigurations = {
        dev = nixosSystem {
          system = x86_64-linux;
          specialArgs = {
            unstable = unstable x86_64-linux;
            inherit inputs outputs;
          };
          modules = [
            inputs.disko.nixosModules.disko
            ./configs/dev.nix
            ./modules/common.nix
            ./modules/nixos
          ];
        };
        live = nixosSystem {
          system = "x86_64-linux";
          modules = [
            (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
            ./dev.nix
            ./dev-disk-config.nix
          ];
        };
      };

      packages = {
        x86_64-linux = {
          options-doc =
            let
              pkgs' = import ./packages {
                inherit inputs;
                pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
              };
            in
            pkgs'.options-doc;
        };

      };

      colmena = {
        meta = {
          nixpkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            overlays = [ ];
          };
          specialArgs = {
            unstable = unstable x86_64-linux;
            inherit inputs outputs;
          };
        };

        defaults =
          { ... }:
          {
            imports = [
              inputs.disko.nixosModules.disko
              ./modules/common.nix
              ./modules/nixos
            ];

            deployment = {
              keys = {
                "sops-key" = {
                  name = "keys.txt";
                  keyFile = "/home/dsn/.config/sops/age/keys.txt";
                  destDir = "/home/dsn/.config/sops/age";
                  user = "dsn";
                };
              };
            };
          };

        srv-nixos-01 =
          { ... }:
          {
            imports = [
              ./configs/srv-nixos-01.nix
              inputs.home-manager.nixosModules.home-manager
            ];

            deployment = {
              targetHost = "192.168.2.111";
              targetUser = "dsn";
            };

            home-manager = {

              # saves extra eval, consistency and rm dep on NIX_PATH
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                unstable = unstable x86_64-linux;
                inherit inputs outputs;
              };

              sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

              users.dsn.imports = [
                ./profiles/dsn-small.nix
                ./modules/home/default-sys-module.nix
              ];
            };

            boot.isContainer = true;
          };
      };

      # homeConfigurations = mapAttrs (target: cfg:
      #   homeManagerConfiguration {
      #     pkgs = inputs.nixpkgs.legacyPackages.${cfg.system};
      #     extraSpecialArgs = { inherit inputs outputs; };
      #     modules = [
      #       ./profiles/${cfg.profile}.nix
      #       # { home.stateVersion = cfg.stateVersion; }
      #       # ./hm-modules/all.nix
      #       { inherit (cfg) my-nixos-hm; }
      #     ];
      #   }) (import ./profiles);
    };
}
