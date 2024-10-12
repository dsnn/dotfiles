# shell.nix
with import <nixpkgs> { config.allowUnfree = true; };

mkShell {
  name = "terraform-env";
  packages = [ terraform bind dig ];
}
