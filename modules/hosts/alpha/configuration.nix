{ inputs, ... }:
let
  x86_64-linux = "x86_64-linux";
  extraSpecialArgs = {
    inherit inputs;
    system = x86_64-linux;
  };
  systemSettings = {
    networking = {
      hostName = "alpha";
      dhcpcd.enable = true;
      interfaces.eth0.useDHCP = true;
    };
    boot = {
      loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };
    nixpkgs = {
      hostPlatform = x86_64-linux;
    };
    system = {
      stateVersion = "25.05";
    };
    nixpkgs.config.allowUnfree = true;
  };
in
{
  flake.modules.homeManager.alpha.home.homeDirectory = "/home/dsn";

  flake.homeConfigurations.alpha = inputs.home-manager.lib.homeManagerConfiguration {
    inherit extraSpecialArgs;
    pkgs = inputs.nixpkgs.legacyPackages.${x86_64-linux};
    modules = with inputs.self.modules.homeManager; [
      alpha
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

  flake.nixosConfigurations.alpha = inputs.nixpkgs.lib.nixosSystem {
    system = x86_64-linux;
    modules =
      with inputs.self.modules.nixos;
      [
        disko-btrfs
        environment
        nix
        openssh
        time
        users
        zsh
        systemSettings
      ]
      ++ [ inputs.disko.nixosModules.disko ];
  };
}
