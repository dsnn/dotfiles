{ lib, config, pkgs, isServer, hostname, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  packages = import ../modules/home/packages.nix;
  rebuild-command =
    if isDarwin then "darwin-rebuild" else "sudo -H nixos-rebuild";
in {

  # Fix home manager for non NixOS
  # targets.genericLinux.enable = true;

  imports = lib.concatMap import [
    ../modules/home/programs
    ../modules/home/scripts
    # ../modules/home/services
    ../modules/home/secrets
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "dsn";
    homeDirectory = if isDarwin then "/Users/dsn" else "/home/dsn";
    stateVersion = "23.11";
    packages = packages { inherit pkgs isServer; };
    file."${config.home.homeDirectory}/.hushlogin".text = "";
  };

  home.file."${config.home.homeDirectory}/.inputrc".text = ''
    set show-all-if-ambiguous on
    set completion-ignore-case on
    set mark-directories on
    set mark-symlinked-directories on
    set match-hidden-files off
    set visible-stats on
    set keymap vi
    set editing-mode vi-insert
  '';

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # fonts.fontconfig.enable = true;

  # host specific aliases
  programs.zsh.shellAliases = {
    cfc = "vim $HOME/dotfiles/hosts/${hostname}/configuration.nix";
    cfg = "vim $HOME/dotfiles/modules/home/git.nix";
    cfh = "vim $HOME/dotfiles/profiles/dsn.nix";
    cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
    rf =
      "home-manager switch --flake ~/dotfiles/#${hostname}; source ~/.config/zsh/.zshrc";
    rs = "${rebuild-command} switch --flake ~/dotfiles/#${hostname}";
    ru = "pushd ~/dotfiles; nix flake update; rf; popd";
  };
}
