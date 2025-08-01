# change to predicate and define unfree pkgs explicitly.
{
  flake.modules.homeManager.silver =
    { lib, ... }:
    {
      nixpkgs = {
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
    };
}
