{ inputs, ... }:
let
  x86_64-linux = "x86_64-linux";
  extraSpecialArgs = {
    inherit inputs;
    system = x86_64-linux;
  };
in
{
  flake.homeConfigurations.nixos = inputs.home-manager.lib.homeManagerConfiguration {
    inherit extraSpecialArgs;
    pkgs = inputs.nixpkgs.legacyPackages.${x86_64-linux};
    modules = with inputs.self.modules.homeManager; [
      nixos
      shell
      desktop
      user-dsn
      docker
      i3
      lazygit
      lazysql
      nh
      polybar
      qutebrowser
      rider
    ];
  };

  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = x86_64-linux;
    modules = with inputs.self.modules.nixos; [
      nixos
      i3
      environment
      nix
      openssh
      time
      users
      xrdp
      zsh
      bluetooth
      xrdp
    ];
  };
}
