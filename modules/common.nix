{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption optionalAttrs;
  cfg = config.dsn.common;
  trustedUsers = [
    "root"
    "dsn"
    "@wheel"
  ];
in
{

  options.dsn.common = {
    enable = mkEnableOption "Enable common stuff";
    enable-darwin = mkEnableOption "Enable environment options";
  };

  config = mkIf cfg.enable {
    environment =
      {
        shells = with pkgs; [
          bash
          zsh
        ];
        systemPackages = with pkgs; [
          age
          coreutils
          git
          home-manager
          htop
          man
          vim
          wget
          nix

          # system monitoring
          # sysstat
          # iotop
          # iftop
          # btop
          # nmon
          # sysbench

          # networking tools
          # mtr # A network diagnostic tool
          # iperf3
          # dnsutils # `dig` + `nslookup`
          # ldns # replacement of `dig`, it provide the command `drill`
          # wget
          # curl
          # aria2 # A lightweight multi-protocol & multi-source command-line download utility
          # socat # replacement of openbsd-netcat
          # nmap # A utility for network discovery and security auditing
          # ipcalc # it is a calculator for the IPv4/v6 addresses

          # misc
          # file
          # findutils
          # which
          # tree
          # gnutar
          # rsync
        ];
      }
      // optionalAttrs cfg.enable-darwin {
        loginShell = pkgs.zsh;
        systemPath = [ "/opt/homebrew/bin" ];
        pathsToLink = [ "/Applications" ];
      };

    time.timeZone = "Europe/Stockholm";

    nix = {
      package = pkgs.nix;
      # package = pkgs.nixFlakes;
      channel.enable = false;
      settings = {
        # keep-derivations = false; # nix-darwin only?
        # sandbox = "relaxed";
        allowed-users = trustedUsers;
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        http-connections = 50;
        log-lines = 50;
        trusted-users = trustedUsers;
        warn-dirty = false;

        substituters = [
          "http://cache.dsnn.io"
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.dsnn.io:1IY1jXcL3Ra4hRuv2L3+I7g37I6YWDksX8A744KLOng"
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };

      # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
      # nix.registry.nixpkgs.flake = nixpkgs;

      # environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
      # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
      # discard all the default paths, and only use the one from this flake.
      # nix.nixPath = lib.mkForce [ "/etc/nix/inputs" ];

      # https://github.com/NixOS/nix/issues/9574
      # nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

      gc =
        {
          automatic = true;
          options = "--delete-older-than 30d";
        }
        // optionalAttrs cfg.enable-darwin {
          interval = {
            Weekday = 0;
            Hour = 0;
            Minute = 0;
          };
        };
    };
  };
}
