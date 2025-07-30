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

  # home
  # flake.modules.home.silver.imports = with inputs.self.modules.home; [
  # ];

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
