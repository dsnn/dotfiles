{ inputs, ... }:
let
  # pkgs' = import ./packages {
  #   inherit inputs;
  #   pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  # };
  vars = import ./variables { inherit inputs; };
  myLib = import ./lib { inherit inputs; };
  inherit (vars.system) x86_64-linux aarch64-darwin;
in
{
  # for debugging
  debugAttr = {
    inherit vars myLib;
  };

  homeConfigurations = {
    silver = myLib.home.mkHome aarch64-darwin "silver";
    dev = myLib.home.mkHome x86_64-linux "dev";
  };

  darwinConfigurations = {
    silver = myLib.system.mkDarwin "silver";
  };

  nixosConfigurations = {
    dev = myLib.system.mkNixos "dev";
  };

  # packages = {
  #   x86_64-linux = {
  #     proxmox-lxc = myLib.generate.proxmox-lxc;
  #     options-doc = pkgs'.options-doc;
  #   };
  # };

  colmena = {
    meta = myLib.colmena.meta;
    defaults = myLib.colmena.defaults;
  } // builtins.mapAttrs (name: host: myLib.colmena.mkDeployment host) vars.networking.hostsAddr;
}
