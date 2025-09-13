{ inputs, nixpkgs, ... }:
{
  flake.colmenaHive = inputs.colmena.lib.makeHive {
    meta = {
      nixpkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ ];
      };
    };

    alpha = {
      deployment = {
        targetUser = "root";
        targetHost = "192.168.1.133";
        targetPort = 22;
        tags = [ "alpha" ];
        buildOnTarget = true;
      };

      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.self.modules.nixosConfigurations.alpha
      ];
    };
  };
}
