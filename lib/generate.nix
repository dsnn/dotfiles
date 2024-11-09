{
  inputs,
  unstable,
  vars,
  ...
}:
let
  inherit (vars) system generateOptions;
in
{
  proxmox-lxc = inputs.nixos-generators.nixosGenerate {
    system = system.x86_64-linux;
    specialArgs = {
      unstable = unstable system.x86_64-linux;
      inherit inputs vars;
    };
    modules = [
      ../hosts/templates/proxmox-lxc
      ../modules/sets/common.nix
      ../modules/nixos
    ];
    format = generateOptions.formats.proxmox-lxc;
  };
}
