{ inputs, ... }:
let

  inherit (inputs.self.lib.mk-os)
    darwin
    ;
in
{
  # outputs
  flake.homeConfigurations.silver = darwin "silver";
  flake.darwinConfigurations.silver = darwin "silver";

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
  ];

  # system
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
