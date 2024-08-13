{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.dsn.common;
  trustedUsers = [ "root" "dsn" "@wheel" ];
in {

  options.dsn.common = {
    enable = mkEnableOption "Enable common stuff";
    enable-darwin = mkEnableOption "Enable environment options";
  };

  config = mkIf cfg.enable {
    environment = {
      shells = with pkgs; [ bash zsh ];
      systemPackages = with pkgs; [
        age
        coreutils
        git
        home-manager
        htop
        man
        sops
        vim
        wget
        nix
      ];
    } // optionalAttrs cfg.enable-darwin {
      loginShell = pkgs.zsh;
      systemPath = [ "/opt/homebrew/bin" ];
      pathsToLink = [ "/Applications" ];
    };

    time.timeZone = "Europe/Stockholm";

    nix = {
      package = pkgs.nix;
      # package = pkgs.nixFlakes;
      # channel.enable = false;
      settings = {
        # keep-derivations = false; # nix-darwin only?
        # sandbox = "relaxed";
        allowed-users = trustedUsers;
        auto-optimise-store = true;
        experimental-features = "nix-command flakes";
        http-connections = 50;
        log-lines = 50;
        trusted-users = trustedUsers;
        warn-dirty = false;

        substituters =
          [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };

      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      } // optionalAttrs cfg.enable-darwin {
        interval = {
          Weekday = 0;
          Hour = 0;
          Minute = 0;
        };
      };

      # nixPath = [
      #   {
      #     path = "/nix/var/nix/profiles/per-user/root/channels/nixos";
      #     prefix = "nixpkgs";
      #   }
      #   {
      #     path = "/Users/dsn/dotfiles/hosts/silver/configuration.nix";
      #     prefix = "darwin-config";
      #   }
      #   "/nix/var/nix/profiles/per-user/root/channels"
      # ];

    };
  };
}
