{
  flake.modules.packages.vma =
    {
      inputs,
      genSpecialArgs,
      host,
      ...
    }:
    let
      format = "proxmox";
      system = "x86_64-linux";
    in
    inputs.nixos-generators.nixosGenerate {
      inherit system format;
      specialArgs = genSpecialArgs system;
      modules = [
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
        ../modules/nixos
        ./proxmox-image.nix
      ];
    };
}
