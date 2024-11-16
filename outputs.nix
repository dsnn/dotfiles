{ inputs, ... }:
let
  # pkgs' = import ./packages {
  #   inherit inputs;
  #   pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  # };
  myvars = import ./variables { inherit inputs; };
  mylib = import ./lib { inherit inputs; };
  inherit (myvars.system) x86_64-linux aarch64-darwin;
in
{
  # for debugging
  debugAttr = {
    inherit myvars mylib;
  };

  homeConfigurations = {
    silver = mylib.home.mkHome aarch64-darwin "silver";
    dev = mylib.home.mkHome x86_64-linux "dev";
  };

  darwinConfigurations = {
    silver = mylib.system.mkDarwin "silver";
  };

  nixosConfigurations = {
    dev = mylib.system.mkNixos "dev";
  };

  # packages = {
  #   x86_64-linux = {
  #     proxmox-lxc = mylib.generate.proxmox-lxc;
  #     options-doc = pkgs'.options-doc;
  #   };
  # };

  colmena = {
    meta = mylib.colmena.meta;
    defaults = mylib.colmena.defaults;
  } // builtins.mapAttrs (name: host: mylib.colmena.mkDeployment host) myvars.networking.hostsAddr;
}
