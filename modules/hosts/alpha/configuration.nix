{ inputs, ... }:
let
  x86_64-linux = "x86_64-linux";
  extraSpecialArgs = {
    inherit inputs;
    system = x86_64-linux;
  };
in
{
  # host specific settings
  flake.modules.nixos.alpha = {
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

  flake.modules.homeManager.kitty = {
    programs.kitty = {
      enable = true;
    };
  };

  flake.homeConfigurations.alpha = inputs.home-manager.lib.homeManagerConfiguration {
    inherit extraSpecialArgs;
    pkgs = inputs.nixpkgs.legacyPackages.${x86_64-linux};
    modules =
      with inputs.self.modules.homeManager;
      [
        alpha
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
        ssh
        user-dsn
        volta
        xdg
        kitty
      ]
      ++ [
        {
          # host specific home-manager settings
          home.homeDirectory = "/home/dsn";
        }
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
      ++ [ inputs.disko.nixosModules.disko ];
  };
}
