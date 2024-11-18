{
  inputs,
  myvars,
  genSpecialArgs,
  ...
}:
let
  inherit (myvars) system generateOptions;
in
inputs.nixos-generators.nixosGenerate {
  system = system.x86_64-linux;
  specialArgs = genSpecialArgs system.x86_64-linux;
  modules = [
    ../hosts/templates/proxmox-lxc
    ../modules/sets/common.nix
    ../modules/nixos
  ];
  format = generateOptions.formats.proxmox-lxc;
}
