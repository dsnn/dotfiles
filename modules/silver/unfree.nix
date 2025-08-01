# change to predicate and define unfree pkgs explicitly.
{
  flake.modules.home.silver.unfree =
    { lib }:
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
