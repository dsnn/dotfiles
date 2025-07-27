{
  description = "My dotfiles and infrastructure";

  outputs = inputs: import ./outputs.nix inputs;

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    colmena.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";

    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/latest";

    flake-checker.inputs.nixpkgs.follows = "nixpkgs";
    flake-checker.url = "github:DeterminateSystems/flake-checker";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";

    impermanence.url = "github:nix-community/impermanence";

    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    nix-ld.url = "github:Mic92/nix-ld";

    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators";

    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/nixos-25.05";

    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

    terranix.inputs.nixpkgs.follows = "nixpkgs";
    terranix.url = "github:terranix/terranix";
  };
}
