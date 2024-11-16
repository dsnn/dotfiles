{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  inherit (myvars.system) x86_64-linux;
  myvars = import ./variables { inherit lib; };
  mylib = import ./lib { inherit lib; };
  pkgs' = import ./packages { inherit inputs; };
  hosts = myvars.networking.hostsAddr;

  unstable =
    system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

  args = {
    inherit inputs unstable myvars;
  };
in
{
  debugAttr = {
    inherit myvars mylib;
  };

  homeConfigurations.${hosts.silver.name} = mylib.homeConfig (args // hosts.silver);
  homeConfigurations.${hosts.dev.name} = mylib.homeConfig (args // hosts.dev);
  darwinConfigurations.${hosts.silver.name} = mylib.darwinsystem (args // hosts.silver);
  nixosConfigurations.${hosts.dev.name} = mylib.nixosSystem (args // hosts.dev);

  packages.x86_64-linux.options-doc = pkgs'.options-doc;

  colmena = {
    meta = {
      nixpkgs = import inputs.nixpkgs { system = x86_64-linux; };
      specialArgs = {
        unstable = unstable x86_64-linux;
        inherit inputs myvars;
      };
    };
  } // builtins.mapAttrs (name: host: mylib.colmenaSystem (args // { inherit host; })) hosts;
}
