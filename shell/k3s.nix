let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config.allowUnfree = true; };
in
pkgs.mkShellNoCC {
  name = "k3s";
  packages = with pkgs; [
    k3s
    kubernetes-helm
    kustomize
  ];
}
