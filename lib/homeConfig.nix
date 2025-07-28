{
  inputs,
  host,
  genSpecialArgs,
  ...
}:
let
  inherit (host)
    hostname
    system
    home-modules
    profiles
    ;
in
inputs.home-manager.lib.homeManagerConfiguration {
  extraSpecialArgs = (genSpecialArgs system) // {
    inherit hostname system;
  };
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  modules = home-modules ++ profiles;
}
