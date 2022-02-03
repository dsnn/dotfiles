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
    lazygit
    neovim
    nixfmt
    nixpkgs-fmt
    nodePackages.npm
    nodejs
    ripgrep
    rnix-lsp
  ];

}
