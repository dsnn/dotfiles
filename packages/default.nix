{ inputs, ... }@args:
let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  options-doc = pkgs.callPackage ./options-doc.nix args;
}
