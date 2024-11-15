{
  description = "My dotfiles and infrastructure";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";

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

    impermanence.url = "github:nix-community/impermanence";

    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    nix-ld.url = "github:Mic92/nix-ld";

    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators";

    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";

    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

    terranix.inputs.nixpkgs.follows = "nixpkgs";
    terranix.url = "github:terranix/terranix";
  };
  outputs =
    inputs@{ self, ... }:
    let
      # pkgs' = import ./packages {
      #   inherit inputs;
      #   pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      # };
      vars = import ./variables { inherit inputs; };
      myLib = import ./lib { inherit inputs; };
      inherit (vars.system) x86_64-linux aarch64-darwin;
    in
    {
      # for debugging
      debugAttr = {
        inherit vars myLib;
      };

      # Home manager as a module (NixOS configurations)
      homeManagerModules.default = ./modules/home;
      # modules = [ ... inputs.self.outputs.homeManagerModules.default ]

      homeConfigurations = {
        silver = myLib.home.mkHome aarch64-darwin "silver";
        dev = myLib.home.mkHome x86_64-linux "dev";
      };

      darwinConfigurations = {
        silver = myLib.system.mkDarwin "silver";
      };

      nixosConfigurations = {
        dev = myLib.system.mkNixos "dev";
      };

      # packages = {
      #   x86_64-linux = {
      #     proxmox-lxc = myLib.generate.proxmox-lxc;
      #     options-doc = pkgs'.options-doc;
      #   };
      # };

      colmena = {
        meta = myLib.colmena.meta;
        defaults = myLib.colmena.defaults;
      } // builtins.mapAttrs (name: host: myLib.colmena.mkDeployment host) vars.networking.hostsAddr;
    };
}
