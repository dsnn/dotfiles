# TODO: Add options for integrations with other apps.
# E.g tmux, zsh etc.
# Review and add more cool integrations like zsh-fzf-tab, alot of nice stuff out there!
{ ... }:
{
  imports = [
    ./fzf.nix
  ];

  # home.packages = with pkgs; [ zsh-fzf-tab ];
}
