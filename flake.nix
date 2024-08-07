{
  description = "Nix configuration";

  inputs = {
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    flake-checker.url = "github:DeterminateSystems/flake-checker";
    flake-checker.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
    terranix.url = "github:terranix/terranix";
    terranix.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, darwin, home-manager, sops-nix, nixos-wsl
    , nix-ld, nixos-generators, terranix, disko, ... }:
    let
      inherit (self) outputs;
      aarch64-darwin = "aarch64-darwin";
      # x86_64-linux = "x86_64-linux";
    in {

      homeConfigurations.silver = home-manager.lib.homeManagerConfiguration {
        modules = [ ./profiles/dsn.nix ];
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {
          inherit inputs outputs;
          isServer = false;
          hostname = "silver";
        };
      };

      darwinConfigurations.silver = darwin.lib.darwinSystem {
        modules = [ ./hosts/silver/configuration.nix ];
        specialArgs = { inherit inputs outputs; };
        system = aarch64-darwin;
      };

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
