{ inputs, ... }:
let
  inherit (inputs.self.lib.mk-os) darwin;
in
{
  flake.homeConfigurations.silver = darwin "silver";
  flake.darwinConfigurations.silver = darwin "silver";
}
