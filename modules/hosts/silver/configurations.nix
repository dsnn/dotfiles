{ inputs, ... }:
let
  aarch64-darwin = "aarch64-darwin";
  extraSpecialArgs = {
    inherit inputs;
    system = aarch64-darwin;
  };
in
{

  flake.homeConfigurations.silver = inputs.home-manager.lib.homeManagerConfiguration {
    inherit extraSpecialArgs;
    pkgs = inputs.nixpkgs.legacyPackages.${aarch64-darwin};
    modules = with inputs.self.modules.homeManager; [
      bottom
      direnv
      docker
      git
      just
      keychain
      lazygit
      nh
      qutebrowser
      shell
      silver
      ssh
      user-dsn
      volta
      xdg
    ];
  };

  flake.darwinConfigurations.silver = inputs.darwin.lib.darwinSystem {
    system = aarch64-darwin;
    modules = with inputs.self.modules.darwin; [
      silver
      docker
      environment
      homebrew
      nix
      security
      time
      users
      zsh
    ];
  };
}
