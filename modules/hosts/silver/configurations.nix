{ inputs, ... }:
let
  aarch64-darwin = "aarch64-darwin";
  extraSpecialArgs = {
    inherit inputs;
    system = aarch64-darwin;
  };
  systemSettings = {
    networking = {
      hostName = "silver";
    };
    nixpkgs = {
      hostPlatform = aarch64-darwin;
    };
    system = {
      system.stateVersion = 6;
      primaryUser = "dsn";
      defaults = {
        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          AppleShowAllExtensions = true;
          InitialKeyRepeat = 15;
          KeyRepeat = 2;
        };
        dock = {
          autohide = true;
          orientation = "bottom";
          show-recents = false;
        };
        finder = {
          AppleShowAllExtensions = true;
          _FXShowPosixPathInTitle = true;
        };
      };
    };
  };
in
{
  flake.modules.homeManager.silver.home.homeDirectory = "/Users/dsn";

  flake.homeConfigurations.silver = inputs.home-manager.lib.homeManagerConfiguration {
    inherit extraSpecialArgs;
    pkgs = inputs.nixpkgs.legacyPackages.${aarch64-darwin};
    modules = with inputs.self.modules.homeManager; [
      silver
      qutebrowser
      bottom
      direnv
      docker
      git
      just
      keychain
      lazygit
      nh
      shell
      ssh
      volta
      xdg
      packages
    ];
  };

  flake.darwinConfigurations.silver = inputs.darwin.lib.darwinSystem {
    system = aarch64-darwin;
    modules = with inputs.self.modules.darwin; [
      docker
      environment
      homebrew
      systemSettings
      nix
      security
      time
      users
      zsh
    ];
  };
}
