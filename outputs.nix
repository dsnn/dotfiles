{ ... }@inputs:
let
  inherit (inputs.nixpkgs) lib;

  genSpecialArgs = system: {
    inherit inputs;

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
      genSpecialArgs
      ;

    systems = {
      aarch64-darwin = "aarch64-darwin";
      x86_64-linux = "x86_64-linux";
    };

  };

  laptop = import ./laptop/default.nix args;
in
{
  homeConfigurations.silver = laptop.home;
  darwinConfigurations.silver = laptop.system;
}
