{ pkgs, ... }: {

  # Fix home manager for non NixOS
  targets.genericLinux.enable = true;

  imports = [
    ../../modules/home/fzf
    ../../modules/home/git
    ../../modules/home/lazygit
    ../../modules/home/starship
    ../../modules/home/tmux
    ../../modules/home/xdg
    ../../modules/home/zsh
  ];

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    curl
    fd
    htop
    jq
    nawk
    neovim
    nixfmt
    nixpkgs-fmt
    nil
    ripgrep
    unzip
    vim
    xclip
  ];
}
