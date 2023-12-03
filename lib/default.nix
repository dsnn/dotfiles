{ nixpkgs, home-manager, ... }: {

  mkHome = { system, ... }:
    home-manager.lib.homeManagerConfiguration {
      modules = [ ../home.nix ];
      pkgs = import nixpkgs { inherit system; };
      extraSpecialArgs = { inherit system; };
    };
}

