{ inputs, ... }:
let
  x86_64-linux = "x86_64-linux";
  hostSettings = {
    nixpkgs.hostPlatform = x86_64-linux;
    boot.loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    networking = {
      hostName = "alpha";
      dhcpcd.enable = true;
      interfaces.eth0.useDHCP = true;
    };
    system = {
      stateVersion = "25.05";
    };

    nixpkgs.config.allowUnfree = true;
  };
in
{

  flake.homeConfigurations.alpha = inputs.home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = {
      inherit inputs;
    }
    // {
      system = x86_64-linux;
    };
    pkgs = inputs.nixpkgs.legacyPackages.${x86_64-linux};
    modules = with inputs.self.modules.homeManager; [
      shell
      alpha
      bottom
      direnv
      git
      lazygit
      just
      keychain
      nh
      ssh
      volta
      xdg
      docker
      # qutebrowser
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
        time
        zsh
        users
        openssh
        system
        hostSettings
      ]
      ++ [ inputs.disko.nixosModules.disko ]
      ++ [ inputs.disko.nixosModules.disko ];
  };
}

# {
#   modulesPath,
#   pkgs,
#   ...
# }:
# {
#   imports = [
#     (modulesPath + "/installer/scan/not-detected.nix")
#     ./disko.nix
#   ];
#
#   dsn = {
#     i18n.enable = true;
#     nix.enable = true;
#     openssh.enable = true;
#     prometheus.enable = true;
#     security.enable = true;
#     shells.enable = true;
#     sops.enable = true;
#     systemPackages.enable = true;
#     user.enable = true;
#     systemPackages = {
#       enableMonitoringPkgs = true;
#       enableNetworkingPkgs = true;
#     };
#   };
#
#   environment.systemPackages = with pkgs; [
#     k3s
#   ];
#
#   nix.settings.nix-path = "nixpkgs=flake:nixpkgs";
#   nixpkgs.config.allowUnfree = true;
#
#   boot = {
#     loader.grub = {
#       devices = [ ];
#       efiSupport = true;
#       efiInstallAsRemovable = true;
#     };
#     isContainer = false;
#   };
#
#   programs.zsh.enable = true;
#
#   services.qemuGuest.enable = true;
#
#   networking = {
#     hostName = "nixos-dev";
#     dhcpcd.enable = true;
#     interfaces.eth0.useDHCP = true;
#   };
#
#   system = {
#     stateVersion = "25.05";
#   };
# }
