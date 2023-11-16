{ config, pkgs, lib, ... }: {

  imports = [
    ../../modules/home/tmux.nix
    ../../modules/home/git.nix
    ../../modules/home/lazygit.nix
    ../../modules/home/starship.nix
    ../../modules/home/zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # nix.package = pkgs.nixUnstable;

  # home.username = "dsn";
  # home.homeDirectory = "/Users/dsn";
  home.packages = with pkgs; [
    # docker-compose
    # neovim
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

  programs.zsh.shellAliases = {
    rf = "darwin-rebuild switch --flake ~/dotfiles";
    nixup = "pushd ~/dotfiles; nix flake update; nixswitch; popd";

    cfc = "vim $HOME/dotfiles/hosts/macbook/configuration.nix";
    cfh = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    # TODO: OS specific file shortcuts
    # cfs = "vim $HOME/.ssh/config";
    # cfz = "vim $HOME/dotfiles/home.nix";
    # cfg = "vim $HOME/dotfiles/home.nix";
  };
  programs.zsh.history.path = "/Users/dsn/.config/zsh/history";

  # programs._1password = {
  #   enable = true;
  # };
  # ssh_agent ~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
  # programs._1password-gui = {
  #   enable = true;
  #   polkitPolicyOwners = ["dsn"];
  # };



  # fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;

  home.file.".hushlogin".text =  "";
  home.file.".inputrc".source = ../../modules/home/inputrc;
  home.file.".config/dircolors".source = ../../modules/home/dircolors;
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ../../modules/home/nvim;
  };

  xdg.configFile."karabiner" = {
    source = config.lib.file.mkOutOfStoreSymlink ../../modules/home/karabiner;
  };

}
