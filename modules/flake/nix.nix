{ inputs, ... }:
let
  nix-defaults = {
    enable = true;
    channel.enable = false;
    optimise.automatic = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    settings = {
      http-connections = 50;
      log-lines = 50;
      warn-dirty = false;
      extra-system-features = [ "recursive-nix" ];

      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
        "recursive-nix"
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
in
{
  text.gitignore = ''
    /result
    /result.*
  '';

  flake.modules = {
    nixos.nix =
      { pkgs, ... }:
      {
        nix = nix-defaults // {
          package = pkgs.nix;
          registry.nixpkgs.flake = inputs.nixpkgs;
        };
      };

    darwin.nix =
      { pkgs, ... }:
      {
        nix = nix-defaults // {
          package = pkgs.nix;
          registry.nixpkgs.flake = inputs.nixpkgs;
        };
      };
  };
}
