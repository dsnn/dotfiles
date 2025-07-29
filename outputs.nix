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

  systems = {
    aarch64-darwin = "aarch64-darwin";
    x86_64-linux = "x86_64-linux";
  };

  args = {
    inherit
      inputs
      lib
      systems
      genSpecialArgs
      ;
  };

  laptop = import ./laptop/default.nix args;
in
{
  homeConfigurations.silver = laptop.home;
  darwinConfigurations.silver = laptop.system;

  packages = {
    neovim = inputs.myflakes.packages.${systems.aarch64-darwin}.neovim;
  };
}
