{ pkgs, ... }:
let
  # inherit (pkgs.stdenv) isDarwin;
  # home = if isDarwin then "/Users/dsn" else "/home/dsn";
  trustedUsers = [ "root" "dsn" "@wheel" ];
in {

  # only support darwin via home-manager
  # imports = [ inputs.sops-nix.nixosModules.sops ];
  # sops.age.keyFile = "${home}/.config/sops/age/keys.txt";
  # sops.age.sshKeyPaths = [ ];

  environment.loginShell = pkgs.zsh;
  environment.shells = with pkgs; [ bash zsh ];
  environment.systemPackages = with pkgs; [
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

  nix = {
    package = pkgs.nix;
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

    # gc.interval = lib.mkIf (isDarwin) {
    #   Weekday = 0;
    #   Hour = 0;
    #   Minute = 0;
    # };
  };
}
