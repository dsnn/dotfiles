{
  description = "My dotfiles";

  nixConfig = {
    # abort-on-warn = false;
    extra-experimental-features = [ "pipe-operators" ];
    # allow-import-from-derivation = false;
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ (inputs.import-tree ./modules) ];
      _module.args.rootPath = ./.;
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    myflakes = {
      url = "github:dsnn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-checker = {
      url = "github:DeterminateSystems/flake-checker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/dsnn/secrets.git";
      flake = false;
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    mkdocs-flake = {
      url = "github:applicative-systems/mkdocs-flake";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    files = {
      url = "github:mightyiam/files";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };

    make-shell = {
      url = "github:nicknovitski/make-shell";
    };

    import-tree = {
      url = "github:vic/import-tree";
    };
  };
}
