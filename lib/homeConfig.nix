{
  inputs,
  unstable,
  system,
  name,
  ...
}:
let
  defaultModules = [ ../modules/home ];
in
inputs.home-manager.lib.homeManagerConfiguration {
  extraSpecialArgs = {
    unstable = unstable system;
    inherit inputs;
    hostname = name;
  };
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  modules = defaultModules ++ [ ../profiles/dsn.nix ];
}
