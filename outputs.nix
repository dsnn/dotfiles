{ ... }@inputs:
let
  inherit (inputs.nixpkgs) lib;
  myvars = import ./variables { inherit lib; };
  mylib = import ./lib { inherit lib; };
  mypkgs = import ./packages { inherit inputs; };

  genSpecialArgs = system: {
    inherit inputs myvars mylib;

    unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  args = {
    inherit
      inputs
      lib
      mylib
      myvars
      genSpecialArgs
      ;

  };

  silver = import ./hosts/silver/default.nix args;
in
{
  debugAttr = {
    inherit myvars mylib;
  };

  homeConfigurations.silver = silver.home;
  darwinConfigurations.silver = silver.system;

  packages.x86_64-linux = {
    options-doc = mypkgs.options-doc;
  };
}
