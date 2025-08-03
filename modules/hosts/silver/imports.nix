{ inputs, ... }:
{
  # flake.modules.homeManager.silver.imports = with inputs.self.modules.homeManager; [
  #   # sops
  #   bottom
  #   direnv
  #   gh
  #   git
  #   home-manager
  #   just
  #   karabiner
  #   keychain
  #   lazygit
  #   nh
  #   security
  #   shell
  #   silver
  #   ssh
  #   systemd
  #   tmux
  #   tmuxp
  #   volta
  #   wget
  #   xdg
  # ];

  flake.modules.darwin.silver.imports = with inputs.self.modules.darwin; [
    environment
    homebrew
    nix
    security
    system
    time
    zsh
    { users.users.dsn.home = "/Users/dsn"; }
  ];
}
