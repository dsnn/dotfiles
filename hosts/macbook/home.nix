{ pkgs, config, lib, ... }: {

  imports = [
    ../../modules/home/lazygit
    ../../modules/home/git
    ../../modules/home/neovim
    ../../modules/home/karabiner
    ../../modules/home/starship
    ../../modules/home/tmux
    ../../modules/home/tmuxp
    ../../modules/home/bat
    ../../modules/home/zoxide
    ../../modules/home/fzf
    ../../modules/home/vivid
    ../../modules/home/lsd
    ../../modules/home/zsh
    ../../modules/home/ssh
    ../../modules/home/dircolors
    ../../modules/home/xdg
    ../../modules/home/bin
    ../../modules/home/volta
    ../../modules/home/direnv
    ../../modules/home/wget
    ../../modules/home/keychain
    ../../modules/home/1password
  ];

  home.stateVersion = "23.11";
  home.username = "dsn";
  home.homeDirectory = "/Users/dsn";

  programs.zsh.shellAliases = {
    cfc = "vim $HOME/dotfiles/hosts/macbook/configuration.nix";
    cfg = "vim $HOME/dotfiles/modules/home/git.nix";
    cfh = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfs = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
    rf = "home-manager switch --flake ~/dotfiles/#macbook; source ~/.config/zsh/.zshrc";
    rs = "darwin-rebuild switch --flake ~/dotfiles/#macbook";
    ru = "pushd ~/dotfiles; nix flake update; nixswitch; popd";
  };
  programs.zsh.history.path = "/Users/dsn/.config/zsh/history";

  programs.home-manager.enable = true;

  home.file."/Users/dsn/.hushlogin".text =  "";
  home.file."/Users/dsn/.inputrc".source = ../../modules/home/inputrc;
  home.file."/Users/dsn/.secrets/export.secrets".source = ../../secrets/export.secrets;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # discord
    # google-chrome
    # _1password
    ansible
    ansible-lint
    cksfv
    curl
    fd
    freerdp
    gnused
    htop
    jq
    kitty
    mosh
    nawk
    neovim
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
  ];
}
