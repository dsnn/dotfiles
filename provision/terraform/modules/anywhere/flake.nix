{
  description = "NixOS Anywhere Flake";

  inputs = {
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    nix-ld.url = "github:Mic92/nix-ld";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
  };
  outputs =
    inputs@{ self, ... }:
    let
      inherit (self) outputs;
      x86_64-linux = "x86_64-linux";
      inherit (inputs.nixpkgs.lib) nixosSystem; # mapAttrs;
      unstable =
        system:
        import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
    in
    {
      nixosConfigurations.template = nixosSystem {
        system = x86_64-linux;
        specialArgs = {
          unstable = unstable x86_64-linux;
          inherit inputs outputs;
        };
        modules = [
          inputs.disko.nixosModules.disko
          /home/dsn/dotfiles/hosts/template
        ];
      };
    };
}
