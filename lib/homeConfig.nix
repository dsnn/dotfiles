{
  inputs,
  unstable,
  system,
  name,
  home-modules,
  profiles,
  ...
}:
inputs.home-manager.lib.homeManagerConfiguration {
  extraSpecialArgs = {
    unstable = unstable system;
    inherit inputs;
    hostname = name;
  };
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  modules = home-modules ++ profiles;
}
