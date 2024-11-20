{ inputs, config, lib, pkgs, myvars, ... }:
let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (myvars) trustedUsers;
  inherit (pkgs.stdenv) isDarwin;
  cfg = config.dsn.nix;
in {
  options.dsn.nix = { enable = mkEnableOption "Enable common nix settings"; };

  config = mkIf cfg.enable {
    nix = {
      package = pkgs.nix;
      channel.enable = false;
      optimise.automatic = true;
      settings = {
        allowed-users = trustedUsers;
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
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

      # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
      registry.nixpkgs.flake = inputs.nixpkgs;

      # environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

      # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
      # discard all the default paths, and only use the one from this flake.
      nixPath = lib.mkForce [ "/etc/nix/inputs" ];

      # https://github.com/NixOS/nix/issues/9574
      # nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      } // optionalAttrs isDarwin {
        interval = {
          Weekday = 0;
          Hour = 0;
          Minute = 0;
        };
      };
    };
  };
}
