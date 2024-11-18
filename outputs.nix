{ ... }@inputs:
let
  inherit (inputs.nixpkgs) lib;
  inherit (myvars.system) x86_64-linux;
  myvars = import ./variables { inherit lib; };
  mylib = import ./lib { inherit lib; };
  pkgs' = import ./packages { inherit inputs; };
  hosts = myvars.networking.hostsAddr;

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
      myvars
      mylib
      genSpecialArgs
      ;
  };
in
{
  debugAttr = {
    inherit myvars mylib;
  };

  homeConfigurations.${hosts.dev.name} = mylib.homeConfig (args // hosts.dev);
  nixosConfigurations.${hosts.dev.name} = mylib.nixosSystem (args // hosts.dev);

  homeConfigurations.${hosts.silver.name} = mylib.homeConfig (args // hosts.silver);
  darwinConfigurations.${hosts.silver.name} = mylib.darwinsystem (args // hosts.silver);

  packages.x86_64-linux.options-doc = pkgs'.options-doc;

  colmena = {
    meta = {
      nixpkgs = import inputs.nixpkgs { system = x86_64-linux; };
      specialArgs = genSpecialArgs x86_64-linux;
    };
  } // builtins.mapAttrs (name: host: mylib.colmenaSystem (args // { inherit host; })) hosts;
}
