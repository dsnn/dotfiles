{ inputs, pkgs }:
{
  options-doc = pkgs.callPackage ./options-doc.nix { inherit inputs; };
}
