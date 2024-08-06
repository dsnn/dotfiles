{ pkgs, ... }:
let trustedUsers = [ "root" "dsn" "@wheel" ];
in {

  nixpkgs.config.allowUnfree = true;

  imports = [
    # ../../system/common.nix
    ../../system/darwin/homebrew.nix
    ../../system/darwin/skhd.nix
    # ../../system/darwin/yabai.nix
    #inputs.sops-nix.nixosModules.sops
  ];

  #sops.age.keyFile = "$HOME/.config/sops/age/keys.txt";
  # sops.age.sshKeyPaths = [ ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      # auto-optimise-store = true;
      # keep-derivations = false;
      # sandbox = "relaxed";
      trusted-users = trustedUsers;
      allowed-users = trustedUsers;

      substituters =
        [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    gc = {
      user = "root";
      automatic = true;
      options = "--delete-older-than 30d";
    };

    # gc.interval = lib.mkIf (isDarwin) {
    #   Weekday = 0;
    #   Hour = 0;
    #   Minute = 0;
    # };
  };

  environment.loginShell = pkgs.zsh;
  environment.shells = with pkgs; [ bash zsh ];
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];
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

  # security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      # _HIHideMenuBar = true;
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

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;

  users.users.dsn.home = "/Users/dsn";

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # nix.nixPath = [
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

  programs.zsh.enable = true;
}
