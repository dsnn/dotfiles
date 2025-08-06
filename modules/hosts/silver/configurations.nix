{ inputs, ... }:
let
  inherit (inputs.self.lib.mk-os) darwin;
  system = "aarch64-darwin";
in
{
  flake.homeConfigurations.silver = inputs.home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = { inherit inputs system; };
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = with inputs.self.modules.homeManager; [
      # sops
      bottom
      direnv
      gh
      git
      home-manager
      just
      karabiner
      keychain
      lazygit
      nh
      shell
      silver
      ssh
      systemd
      tmux
      tmuxp
      volta
      wget
      xdg
    ];
  };

  flake.darwinConfigurations.silver = darwin "silver";

  # flake.darwinConfigurations.silver = inputs.nixpkgs.lib.nixosSystem {
  #   inherit system;
  #   modules =
  #     with inputs.self.modules.darwin;
  #     [
  #       environment
  #       homebrew
  #       security
  #       system
  #       time
  #       zsh
  #       { users.users.dsn.home = "/Users/dsn"; }
  #     ]
  #     ++ [
  #       inputs.self.modules.nixos.${system}
  #       inputs.self.modules.nixos.silver
  #       {
  #         networking.hostName = lib.mkDefault "silver";
  #         nixpkgs.hostPlatform = lib.mkDefault system;
  #         system.stateVersion = "25.05";
  #       }
  #     ];
  # };
}
