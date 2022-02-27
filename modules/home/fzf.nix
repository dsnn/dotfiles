{ pkgs, ... }: {

  # enable fzf command line fuzzy finder
  programs.fzf.enable = true;

  # integrate w/ zsh
  programs.fzf.enableZshIntegration = true;
}
