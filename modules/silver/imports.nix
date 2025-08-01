{ inputs, ... }:
{
  flake.modules.home.silver.imports = with inputs.self.modules.home; [
    bottom
    git
    just
    karabiner
    keychain
    lazygit
    shell
    sops
    ssh
    tmux
    tmuxp
    volta
    wget
    xdg
    systemd
    home-manager
    direnv
    silver.home
    silver.zsh
    silver.unfree
  ];

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
