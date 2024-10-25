# shell.nix
with import <nixpkgs> { };

mkShell {
  name = "dotfiles";
  packages = [ mkdocs python3 python311Packages.mkdocs-material ];
}
