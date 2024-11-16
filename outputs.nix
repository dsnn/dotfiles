{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  # pkgs' = import ./packages {
  #   inherit inputs;
  #   pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  # };

  unstable =
    system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

  home = import ./lib/home.nix { inherit inputs unstable myvars; };
  system = import ./lib/system.nix { inherit inputs unstable myvars; };
  colmena = import ./lib/colmena.nix { inherit inputs unstable myvars; };
  # generate = import ./lib/generate.nix { inherit inputs unstable myvars; };

  myvars = import ./variables { inherit lib; };
  mylib = import ./lib { inherit lib; };
  inherit (myvars.system) x86_64-linux aarch64-darwin;
in
# args = {
#   inherit inputs unstable myvars;
# };
{
  # for debugging
  debugAttr = {
    inherit myvars mylib;
  };

  homeConfigurations = {
    silver = home.mkHome aarch64-darwin "silver";
    dev = home.mkHome x86_64-linux "dev";
  };

  darwinConfigurations = {
    silver = system.mkDarwin "silver";
  };

  nixosConfigurations = {
    dev = system.mkNixos "dev";
  };

  # packages = {
  #   x86_64-linux = {
  #     proxmox-lxc = mylib.generate.proxmox-lxc;
  #     options-doc = pkgs'.options-doc;
  #   };
  # };

  colmena = {
    meta = colmena.meta;
    defaults = colmena.defaults;
  } // builtins.mapAttrs (name: host: colmena.mkDeployment host) myvars.networking.hostsAddr;
}
