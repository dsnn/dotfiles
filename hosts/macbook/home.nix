{ config, pkgs, lib, ... }: {

  imports = [
    #../../modules/home/tmux.nix
    ../../modules/home/git.nix
    ../../modules/home/lazygit.nix
    ../../modules/home/starship.nix
    ../../modules/home/zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # nix.package = pkgs.nixUnstable;

  home.packages = with pkgs; [
    # docker-compose
    # neovim
    # tmuxp
    # _1password
    # _1password-gui
    ansible
    ansible-lint
    cksfv
    # coreutils
    curl
    direnv
    fd
    freerdp
    gnused
    htop
    jq
    keychain
    mosh
    nawk
    nixfmt
    nixpkgs-fmt
    packer
    ripgrep
    rnix-lsp
    unzip
    vim
    volta
    wakeonlan
    wget
    xclip
    neovim
    # discord
    # feh
    # google-chrome
    # slack
    # spotify
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  home.stateVersion = "23.11";

  xdg.enable = true;
  # xdg.cacheHome = ~/.local/cache;
  # xdg.configHome = ~/.config;
  # xdg.dataHome = ~/.local/share;

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink /Users/dsn/nixfiles/modules/home/nvim;
  };

  programs.zsh.shellAliases = {
    rf = "darwin-rebuild switch --flake ~/nixfiles";
    nixup = "pushd ~/nixfiles; nix flake update; nixswitch; popd";
  };

  # fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;

  home.file.".inputrc".source = ../../modules/home/inputrc;
  home.file.".hushlogin".text =  "";

  # home.file.".config/nvim".source = ../../modules/home/nvim;
  # home.file.".config/dircolors".source = ../../../dotfiles/files/dircolors;
  # home.file.".config/tmuxp".source = ../../../dotfiles/files/tmuxp;
}
