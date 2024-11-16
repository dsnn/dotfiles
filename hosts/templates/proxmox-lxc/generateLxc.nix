{
  inputs,
  unstable,
  myvars,
  ...
}:
let
  inherit (myvars) system generateOptions;
in
inputs.nixos-generators.nixosGenerate {
  system = system.x86_64-linux;
  specialArgs = {
    unstable = unstable system.x86_64-linux;
    inherit inputs myvars;
  };
  modules = [
    ../hosts/templates/proxmox-lxc
    ../modules/sets/common.nix
    ../modules/nixos
  ];
  format = generateOptions.formats.proxmox-lxc;
}
