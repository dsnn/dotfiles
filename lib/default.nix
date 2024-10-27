{ inputs, ... }:
let
  unstable =
    system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  vars = import ../variables { inherit inputs; };
in
{
  home = import ./home.nix { inherit inputs unstable vars; };
  system = import ./system.nix { inherit inputs unstable vars; };
  colmena = import ./colmena.nix { inherit inputs unstable vars; };
  generate = import ./generate.nix { inherit inputs unstable vars; };
}
