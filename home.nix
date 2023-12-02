{ pkgs, ... }:
let
  # is-linux = pkgs.stdenv.isLinux;
  is-darwin = pkgs.stdenv.isDarwin;
in {


  # Fix home manager for non NixOS
  # targets.genericLinux.enable = true;

  nixpkgs.config.allowUnfree = true;
  # nix.package = pkgs.nixUnstable;

  imports = [ ./modules/home ./modules/collections/zsh.nix ];

  dotfiles.karabiner.enable = true;
  dotfiles.keychain.enable = true;
  dotfiles.kitty.enable = true;
  dotfiles.neovim.enable = true;
  dotfiles.op.enable = true;
  dotfiles.ssh.enable = true;
  dotfiles.volta.enable = true;
  dotfiles.wget.enable = true;

  # fonts.fontconfig.enable = true;
  # programs.firefox.enable = true;
  # services.network-manager-applet = { enable = true; };

  # create symlinks to local shares
  # home.file."private".source = config.lib.file.mkOutOfStoreSymlink /mnt/private;
  # home.file."share".source = config.lib.file.mkOutOfStoreSymlink /mnt/share;
  # home.file."share2".source = config.lib.file.mkOutOfStoreSymlink /mnt/share2;

  # host specific aliases
  programs.zsh.shellAliases = {
    cfc = "vim $HOME/dotfiles/hosts/macbook/configuration.nix";
    cfg = "vim $HOME/dotfiles/modules/home/git.nix";
    cfh = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfs = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
    rf =
      "home-manager switch --flake ~/dotfiles/#macbook; source ~/.config/zsh/.zshrc";
    rs = "darwin-rebuild switch --flake ~/dotfiles/#macbook";
    ru = "pushd ~/dotfiles; nix flake update; rf; popd";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
  home.username = "dsn";
  home.homeDirectory = lib.mkIf is-darwin "/Users/dsn" else "/home/dsn";

  home.file."/Users/dsn/.hushlogin".text = "";
  home.file."/Users/dsn/.inputrc".source = ../../modules/home/inputrc;

  home.packages = with pkgs; [
    # _1password
    # discord
    # google-chrome
    ansible
    ansible-lint
    curl
    fd
    freerdp
    gnused
    htop
    jq
    mosh
    nawk
    neovim
    nil
    nixd
    nixfmt
    nixpkgs-fmt
    packer
    ripgrep
    rnix-lsp
    slack
    spotify
    unzip
    vim
    wakeonlan
    xclip
    # feh
    # sstp
    # discord
    # feh
    # freerdp
    # google-chrome
    # kodi
    # remmina
    # slack
    # spotify
    # sstp
    # teamspeak_client
    # wireguard
    # xcape
    # xfce.thunar
  ];


  # for thunar: removable memdia, smb etc
  # services.gvfs.enable = true;

  # for thunar: external program to generate thumbnails
  # services.tumbler.enable = true;
}
