{
  description = "My dotfiles";

  nixConfig = {
    # abort-on-warn = false;
    extra-experimental-features = [ "pipe-operators" ];
    # allow-import-from-derivation = false;
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    myflakes = {
      url = "github:dsnn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";

    flake-checker.inputs.nixpkgs.follows = "nixpkgs";
    flake-checker.url = "github:DeterminateSystems/flake-checker";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";

    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/latest";

    colmena.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";

    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    nix-ld.url = "github:Mic92/nix-ld";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # inputs in module(s) and generate flake.nix instead ?
    # flake-file.inputs = {
    #   flake-file.url = "github:vic/flake-file";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # tell nix about non-standard outputs (like lib for `nix flake show`)
    # inputs.flake-schemas.url = "github:DeterminateSystems/flake-schemas";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    make-shell.url = "github:nicknovitski/make-shell";

    import-tree.url = "github:vic/import-tree";
  };

  # outputs =
  #   { ... }@inputs:
  #   let
  #     inherit (inputs.nixpkgs) lib;
  #
  #     genSpecialArgs = system: {
  #       inherit inputs;
  #
  #       unstable = import inputs.nixpkgs-unstable {
  #         inherit system;
  #         config.allowUnfree = true;
  #       };
  #
  #       stable = import inputs.nixpkgs-stable {
  #         inherit system;
  #         config.allowUnfree = true;
  #       };
  #     };
  #
  #     systems = {
  #       aarch64-darwin = "aarch64-darwin";
  #       x86_64-linux = "x86_64-linux";
  #     };
  #
  #     args = {
  #       inherit
  #         inputs
  #         lib
  #         systems
  #         genSpecialArgs
  #         ;
  #     };
  #
  #     silver = import ./hosts/silver/default.nix args;
  #     # dev = import ./hosts/dev/default.nix args;
  #     # iso = import ./packages/iso args;
  #     # vma = import ./packages/vma args;
  #   in
  #   inputs.flake-parts.lib.mkFlake { inherit inputs; } {
  #
  #     imports = [
  #       (inputs.import-tree ./newModules)
  #     ];
  #
  #     # _module.args.rootPath = ./.;
  #
  #     # homeConfigurations.silver = silver.home;
  #     # darwinConfigurations.silver = silver.system;
  #
  #     # homeConfigurations.dev = dev.home;
  #     # nixosConfigurations.dev = dev.system;
  #
  #     # packages = {
  #     #   # neovim = inputs.myflakes.packages.${systems.aarch64-darwin}.neovim;
  #     #   ${systems.x86_64-linux} = {
  #     #     inherit iso vma;
  #     #   };
  #     # };
  #   };
}
