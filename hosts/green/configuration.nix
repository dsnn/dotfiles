{ inputs, pkgs, ... }: {

  programs.nix-ld.dev.enable = true;

  networking.hostName = "green";
  time.timeZone = "Europe/Stockholm";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = "dsn";
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = false;
  };

  # wsl.enable = true;
  # wsl.defaultUser = "dsn";
  # wsl.automountPath = "/mnt";
  # wsl.startMenuLaunchers = true;

  nix = {
    settings = {
      trusted-users = [ "dsn" ];
      accept-flake-config = true;
      auto-optimise-store = true;
    };

    registry = { nixpkgs = { flake = inputs.nixpkgs; }; };

    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  programs.zsh.enable = true;

  users.users.dsn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel " ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    inetutils
    home-manager
    gcc
    (import ../../system/wsl/wsl2yank.nix { inherit pkgs; })
  ];

  system.stateVersion = "23.05";
}
