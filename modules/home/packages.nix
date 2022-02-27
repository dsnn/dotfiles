{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
    bat
    fzf
    git
    htop
    keychain
    nawk
    starship
    tmux
    unzip
    vim
    wget
    xclip
    zsh
    jq
    neovim
    nixfmt
    nixpkgs-fmt
    nodePackages.npm
    nodejs
    ripgrep
    fd
    rnix-lsp
    sumneko-lua-language-server
    _1password
    _1password-gui
    vault
    pavucontrol
    firefox
    direnv
  ];

}
