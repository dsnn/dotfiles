{ ... }:
let
  # change to predicate and define unfree pkgs explicitly.
  nixpkgs-config = {
    config = {
      allowUnfree = true;
      # allowUnfreePredicate =
      #   pkg:
      #   builtins.elem (lib.getName pkg) [
      #     "1password"
      #     "spotify"
      #   ];
    };
  };
in
{
  flake.modules.homeManager = {
    alpha.nixpkgs = nixpkgs-config;
    silver.nixpkgs = nixpkgs-config;
  };
}
