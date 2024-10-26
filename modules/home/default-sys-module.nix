{ ... }:
{
  # for home manager in nixos (in other words: not standalone)
  imports = [
    ./bat.nix
    ./bottom.nix
    ./dircolors
    ./fzf.nix
    ./git.nix
    ./inputrc.nix
    # ./just.nix
    # ./keychain.nix
    # ./lazygit.nix
    ./lsd.nix
    # ./neovim
    ./packages.nix
    # ./sops.nix
    ./ssh.nix
    ./starship.nix
    # ./tmux.nix
    # ./tmuxp.nix
    ./vivid.nix
    # ./volta.nix
    ./wget.nix
    ./xdg.nix
    ./xresources.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
