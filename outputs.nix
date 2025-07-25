{ self, ... }@inputs:
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

  getConfigurations =
    configuration:
    mylib.mergeAttrs (
      map (
        currentHost:
        let
          inherit (currentHost) name;
          host = import ./hosts/${name}/default.nix args // {
            host = currentHost;
          };
        in
        if builtins.hasAttr configuration host then { ${name} = host.${configuration}.${name}; } else { }
      ) (builtins.attrValues myvars.hosts.hostsAddr)
    );
in
{
  debugAttr = {
    inherit myvars mylib;
  };

  # System configurations
  homeConfigurations = getConfigurations myvars.configurations.home;
  nixosConfigurations = getConfigurations myvars.configurations.nixos;
  darwinConfigurations = getConfigurations myvars.configurations.darwin;

  # Generate raw disk images & options docs
  packages.x86_64-linux = {
    options-doc = mypkgs.options-doc;
    raw = self.nixosConfigurations.raw.config.system.build.diskoImages;
  } // getConfigurations myvars.configurations.generate;

  # Remote deployment
  colmena = {
    meta = {
      nixpkgs = import inputs.nixpkgs { system = myvars.system.x86_64-linux; };
      specialArgs = genSpecialArgs myvars.system.x86_64-linux;
    };
  } // getConfigurations myvars.configurations.colmena;
}
