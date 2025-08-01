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
    silver.packages
  ];

  flake.modules.darwin.silver.imports = with inputs.self.modules.darwin; [
    environment
    homebrew
    nix
    security
    system
    time
    { users.users.dsn.home = "/Users/dsn"; }
  ];
}
