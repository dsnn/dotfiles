{ inputs, ... }:
let
  inherit (inputs.self.lib.mk-os) darwin home;
in
{
  flake.homeConfigurations.silver = home "silver";
  flake.darwinConfigurations.silver = darwin "silver";
}
