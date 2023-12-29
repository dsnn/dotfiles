{ inputs, pkgs, ... }:
let trustedUsers = [ "root" "dsn" "@wheel" ];
in {

  imports = [ inputs.sops-nix.nixosModules.sops ./sops.nix ];

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
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      auto-optimise-store = true;
      # sandbox = "relaxed";
      trusted-users = trustedUsers;
      allowed-users = trustedUsers;
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
}
