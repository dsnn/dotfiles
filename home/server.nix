{ config, pkgs, lib, ... }: {
  imports = [
    ./shared.nix
    ../modules/xdg.nix
    ../modules/awesome.nix
    ../modules/kitty.nix
    ../modules/lazygit.nix
  ];

  home.packages = with pkgs; [
    bat
    fzf
    git
    htop
    keychain
    nawk
    starship
    tmux
    unzip
    wget
    xclip
    zsh
    jq
    neovim
    _1password
  ];
}
