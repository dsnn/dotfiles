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
  };
  outputs = inputs@{ self, ... }:
    let
      inherit (self) outputs;
      aarch64-darwin = "aarch64-darwin";
      # x86_64-linux = "x86_64-linux";
      # inherit (inputs.nixpkgs.lib) nixosSystem mapAttrs;
      inherit (inputs.darwin.lib) darwinSystem;
      inherit (inputs.home-manager.lib) homeManagerConfiguration;
    in {

      homeConfigurations.silver = homeManagerConfiguration {
        modules = [ ./profiles/dsn.nix ./modules/home ];
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "silver";
        };
      };

      darwinConfigurations.silver = darwinSystem {
        modules =
          [ ./configs/silver.nix ./modules/common.nix ./modules/darwin ];
        specialArgs = { inherit inputs outputs; };
        system = aarch64-darwin;
      };

      packages.aarch64-darwin.options-doc = let
        pkgs' = import ./packages {
          pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
        };
      in pkgs'.options-doc;

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

      # colmena = {
      #   meta = {
      #     nixpkgs = import nixpkgs {
      #       system = "x86_64-linux";
      #       overlays = [ ];
      #     };
      #   };
      #
      #   # This module will be imported by all hosts
      #   defaults = { pkgs, ... }: {
      #     environment.systemPackages = with pkgs; [ vim wget curl git sudo ];
      #
      #     # enable and allow ssh
      #     services.openssh = {
      #       enable = true;
      #       passwordAuthentication = true;
      #     };
      #     networking.firewall.allowedTCPPorts = [ 22 ];
      #
      #     systemd.mounts = [{
      #       where = "/sys/kernel/debug";
      #       enable = false;
      #     }];
      #
      #     boot.isContainer = true;
      #     time.timeZone = "Europe/Stockholm";
      #
      #     system = { stateVersion = "23.05"; };
      #   };
      #
      #   srv-nixos-01 = import ./hosts/srv-nixos {
      #     name = "srv-nixos-01";
      #     targetHost = "192.168.2.111";
      #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #     inherit inputs;
      #   };
      #   srv-nixos-02 = import ./hosts/srv-nixos {
      #     name = "srv-nixos-02";
      #     targetHost = "192.168.2.112";
      #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #     inherit inputs;
      #   };
      #   srv-nixos-03 = import ./hosts/srv-nixos {
      #     name = "srv-nixos-03";
      #     targetHost = "192.168.2.113";
      #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #     inherit inputs;
      #   };
      # };
    };
}
