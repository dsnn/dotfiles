{
  inputs,
  system,
  name,
  home-modules,
  profiles,
  genSpecialArgs,
  ...
}:
inputs.home-manager.lib.homeManagerConfiguration {
  extraSpecialArgs = (genSpecialArgs system) // {
    hostname = name;
  };
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  modules = home-modules ++ profiles;
}
