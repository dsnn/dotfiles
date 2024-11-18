{
  inputs,
  host,
  genSpecialArgs,
  ...
}:
let
  inherit (host)
    name
    system
    home-modules
    profiles
    ;
in
inputs.home-manager.lib.homeManagerConfiguration {
  extraSpecialArgs = (genSpecialArgs system) // {
    hostname = name;
  };
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  modules = home-modules ++ profiles;
}
