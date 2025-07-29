{
  inputs,
  genSpecialArgs,
  systems,
  ...
}:
let
  user = "dsn";
  hostname = "dev";
  system = systems.x86_64-linux;
  deployment = {
    targetUser = user;
    targetHost = "192.168.2.10";
    keys = deploymentKeys;
    tags = [ hostname ];
  };
  deploymentKeys = {
    "sops-key" = {
      inherit user;
      name = "keys.txt";
      keyFile = "/home/dsn/.config/sops/age/keys.txt";
      destDir = "/home/dsn/.config/sops/age";
    };
  };
in
{
  system = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = genSpecialArgs system;
    modules = [
      inputs.disko.nixosModules.disko
      inputs.sops-nix.nixosModules.sops
      ../../modules/nixos
      ./disko.nix
      ./configuration.nix
    ];
  };

  deploy =
    { ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        ../../modules/nixos
        ./configuration.nix
      ];

      inherit deployment;
    };
}
