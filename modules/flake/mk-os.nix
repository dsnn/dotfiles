{ inputs, lib, ... }:
let
  flake.lib.mk-os = {
    inherit mkNixos mkDarwin mkHome;
    inherit wsl linux;
    inherit darwin home;
  };

  wsl = mkNixos "x86_64-linux" "wsl";
  linux = mkNixos "x86_64-linux" "nixos";
  darwin = mkDarwin "aarch64-darwin";
  home = mkHome "aarch64-darwin";

  mkHome =
    system: name:
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit system; };
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      modules = [
        inputs.self.modules.home.${name}
      ];
    };

  mkNixos =
    system: cls: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.self.modules.nixos.${name}
        {
          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = "25.05";
        }
      ];
    };

  mkDarwin =
    system: name:
    inputs.darwin.lib.darwinSystem {
      inherit system;
      modules = [
        inputs.self.modules.darwin.${name}
        {
          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = 4; # fix later (increase to 6 (?))
        }
      ];
    };
in
{
  inherit flake;
}
