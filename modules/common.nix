{ pkgs, ... }:
let trustedUsers = [ "root" "dsn" "@wheel" ];
in {

  environment.shells = with pkgs; [ bash zsh ];
  environment.systemPackages = with pkgs; [
    age
    coreutils
    git
    home-manager
    htop
    man
    neovim
    sops
    vim
    wget
  ];

  # sops.age.keyFile = "/secrets/age/keys.txt";

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      auto-optimise-store = true;
      sandbox = "relaxed";
      trusted-users = trustedUsers;
      allowed-users = trustedUsers;
    };

    gc = {
      automatic = true;
      # TODO: review this. darwin only or changed in 23.11?
      # interval = {
      #   Weekday = 0;
      #   Hour = 0;
      #   Minute = 0;
      # };
      options = "--delete-older-than 30d";
    };

    # TODO: review this. darwin only or changed in 23.11?
    # generateNixPathFromInputs = true;
    # linkInputs = true;
    # generateRegistryFromInputs = true;
  };
}
