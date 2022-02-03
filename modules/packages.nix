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
    rnix-lsp
    sumneko-lua-language-server
  ];

}
