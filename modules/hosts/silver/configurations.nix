{ inputs, ... }:
let
  aarch64 = "aarch64-darwin";
in
{
  flake.homeConfigurations.silver = inputs.home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = {
      inherit inputs;
    }
    // {
      system = aarch64;
    };
    pkgs = inputs.nixpkgs.legacyPackages.${aarch64};
    modules = with inputs.self.modules.homeManager; [
      shell
      silver
      bottom
      direnv
      git
      # home-manager
      lazygit
      just
      # karabiner
      keychain
      nh
      ssh
      # systemd
      volta
      xdg
      docker
    ];
  };

  flake.darwinConfigurations.silver = inputs.darwin.lib.darwinSystem {
    system = aarch64;
    modules = with inputs.self.modules.darwin; [
      environment
      homebrew
      nix
      security
      system
      time
      docker
      zsh
      users
      {
        networking.hostName = "silver";
        nixpkgs.hostPlatform = aarch64;
      }
    ];
  };
}
