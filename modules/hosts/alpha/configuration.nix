{ inputs, ... }:
let
  x86_64-linux = "x86_64-linux";
  extraSpecialArgs = {
    inherit inputs;
    system = x86_64-linux;
  };
in
{
  flake.homeConfigurations.alpha = inputs.home-manager.lib.homeManagerConfiguration {
    inherit extraSpecialArgs;
    pkgs = inputs.nixpkgs.legacyPackages.${x86_64-linux};
    modules = with inputs.self.modules.homeManager; [
      alpha
      bottom
      direnv
      docker
      git
      hyprland
      just
      keychain
      kitty
      lazygit
      nh
      qutebrowser
      shell
      ssh
      user-dsn
      volta
      xdg
    ];
  };

  flake.nixosConfigurations.alpha = inputs.nixpkgs.lib.nixosSystem {
    system = x86_64-linux;
    modules =
      with inputs.self.modules.nixos;
      [
        alpha
        disko-btrfs
        environment
        hyprland
        nix
        openssh
        time
        users
        xrdp
        zsh
        bluetooth
      ]
      ++ [ inputs.disko.nixosModules.disko ]
      ++ [ inputs.nixos-hardware.nixosModules.intel-nuc-8i7beh ];
  };
}
