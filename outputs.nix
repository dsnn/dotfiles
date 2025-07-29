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

  silver = import ./hosts/silver/default.nix args;
  # dev = import ./hosts/dev/default.nix args;
  iso = import ./packages/iso args;
  vma = import ./packages/vma args;
in
{
  homeConfigurations.silver = silver.home;
  darwinConfigurations.silver = silver.system;

  # homeConfigurations.dev = dev.home;
  # nixosConfigurations.dev = dev.system;

  packages = {
    # neovim = inputs.myflakes.packages.${systems.aarch64-darwin}.neovim;
    ${systems.x86_64-linux} = {
      inherit iso vma;
    };
  };
}
