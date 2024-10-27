{
  inputs,
  unstable,
  vars,
  ...
}:
let
  inherit (vars) system keyPath keyName;
in
{
  defaults =
    { ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko
        ../modules/common.nix
        ../modules/nixos
      ];

      deployment = {
        keys = {
          "sops-key" = {
            name = keyName;
            keyFile = "${keyPath}/${keyName}";
            destDir = keyPath;
            user = "dsn";
          };
        };
      };
    };

  meta = {
    nixpkgs = import inputs.nixpkgs {
      system = system.x86_64-linux;
      overlays = [ ];
    };
    specialArgs = {
      unstable = unstable system.x86_64-linux;
      inherit inputs;
    };
  };

  mkDeployment =
    args:
    { ... }:
    let
      inherit (args) name ip modules;
    in
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ] ++ modules;

      deployment = {
        targetHost = ip;
        targetUser = vars.username;
      };

      networking.hostName = name;
      networking.interfaces.eth0.ipv4.addresses = [
        {
          address = ip;
          prefixLength = 24;
        }
      ];

      home-manager = {
        # saves extra eval, consistency and rm dep on NIX_PATH
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = {
          unstable = unstable system.x86_64-linux;
          inherit inputs;
        };

        sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

        users.dsn.imports = [
          ../profiles/dsn-small.nix
          ../modules/home/default-sys-module.nix
        ];
      };
    };

}
