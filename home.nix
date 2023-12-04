{ config, pkgs, extraSpecialArgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  inherit (extraSpecialArgs) isServer;
  packages = import ./packages.nix;
  # inherit (lib) mkIf;
in {

  # Fix home manager for non NixOS
  # targets.genericLinux.enable = true;

  imports = [
    ./modules/home/bat.nix
    ./modules/home/bin
    ./modules/home/dircolors
    ./modules/home/direnv.nix
    ./modules/home/fzf.nix
    ./modules/home/git.nix
    ./modules/home/karabiner
    ./modules/home/keychain.nix
    ./modules/home/kitty.nix
    ./modules/home/lazygit.nix
    ./modules/home/lsd.nix
    ./modules/home/neovim
    ./modules/home/op.nix
    ./modules/home/ssh.nix
    ./modules/home/starship.nix
    ./modules/home/tmux.nix
    ./modules/home/tmuxp
    ./modules/home/vivid.nix
    ./modules/home/volta.nix
    ./modules/home/wget.nix
    ./modules/home/xdg.nix
    ./modules/home/zoxide.nix
    ./modules/home/zsh.nix
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

  # TODO: mkIf (isServer && config.network.cifs.enable = true) {
  #   home.file."private".source = config.lib.file.mkOutOfStoreSymlink /mnt/private;
  #   home.file."share".source = config.lib.file.mkOutOfStoreSymlink /mnt/share;
  #   home.file."share2".source = config.lib.file.mkOutOfStoreSymlink /mnt/share2;
  # };

  programs.home-manager.enable = true;

  # fonts.fontconfig.enable = true;

  # host specific aliases
  programs.zsh.shellAliases = {
    cfc = "vim $HOME/dotfiles/hosts/macbook/configuration.nix";
    cfg = "vim $HOME/dotfiles/modules/home/git.nix";
    cfh = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfs = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
    rf =
      "home-manager switch --flake ~/dotfiles/#silver; source ~/.config/zsh/.zshrc";
    rs = "darwin-rebuild switch --flake ~/dotfiles/#silver";
    ru = "pushd ~/dotfiles; nix flake update; rf; popd";
  };

}
