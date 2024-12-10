let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config.allowUnfree = true; };
in
pkgs.mkShellNoCC {
  name = "dotfiles";
  packages = with pkgs; [
    nixos-generators
    colmena
    mkdocs
    python3
    python311Packages.mkdocs-material
  ];
}
