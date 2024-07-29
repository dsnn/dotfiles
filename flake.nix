{
  description = "Nix configuration";

  inputs = {
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    flake-checker.inputs.nixpkgs.follows = "nixpkgs-unstable";
    flake-checker.url = "github:DeterminateSystems/flake-checker";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, darwin, home-manager, sops-nix, nixos-wsl
    , nix-ld, ... }:
    let
      inherit (self) outputs;
      aarch64-darwin = "aarch64-darwin";
      x86_64-linux = "x86_64-linux";
    in {

      homeConfigurations.silver = home-manager.lib.homeManagerConfiguration {
        modules = [ ./home/home.nix ];
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {
          inherit inputs outputs;
          isServer = false;
          hostname = "silver";
        };
      };

      homeConfigurations.grey = home-manager.lib.homeManagerConfiguration {
        modules = [ ./home/home.nix ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          isServer = true;
          hostname = "grey";
        };
      };

      homeConfigurations.black = home-manager.lib.homeManagerConfiguration {
        modules = [ ./home/home.nix ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          isServer = true;
          hostname = "black";
        };
      };

      homeConfigurations.green = home-manager.lib.homeManagerConfiguration {
        modules = [ ./home/home.nix ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          isServer = true;
          hostname = "green";
        };
      };

      darwinConfigurations.silver = darwin.lib.darwinSystem {
        modules = [ ./hosts/silver/configuration.nix ];
        specialArgs = { inherit inputs outputs; };
        system = aarch64-darwin;
      };

      nixosConfigurations.grey = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/grey/configuration.nix nix-ld.nixosModules.nix-ld ];
        specialArgs = { inherit inputs outputs; };
        system = x86_64-linux;
      };

      nixosConfigurations.black = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/black/configuration.nix ];
        specialArgs = { inherit inputs outputs; };
        system = x86_64-linux;
      };

      nixosConfigurations.green = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/green/configuration.nix
          nixos-wsl.nixosModules.wsl
          nix-ld.nixosModules.nix-ld
        ];
        specialArgs = { inherit inputs outputs; };
        system = x86_64-linux;
      };

      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ ];
          };
        };

        # This module will be imported by all hosts
        defaults = { pkgs, ... }: {
          environment.systemPackages = with pkgs; [ vim wget curl git sudo ];

          # enable and allow ssh
          services.openssh = {
            enable = true;
            passwordAuthentication = true;
          };
          networking.firewall.allowedTCPPorts = [ 22 ];

          systemd.mounts = [{
            where = "/sys/kernel/debug";
            enable = false;
          }];

          boot.isContainer = true;
          time.timeZone = "Europe/Stockholm";

          system = { stateVersion = "23.05"; };
        };

        srv-nixos-01 = import ./hosts/srv-nixos {
          name = "srv-nixos-01";
          targetHost = "192.168.2.111";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          inherit inputs;
        };
        srv-nixos-02 = import ./hosts/srv-nixos {
          name = "srv-nixos-02";
          targetHost = "192.168.2.112";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          inherit inputs;
        };
        srv-nixos-03 = import ./hosts/srv-nixos {
          name = "srv-nixos-03";
          targetHost = "192.168.2.113";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          inherit inputs;
        };
      };
    };
}
