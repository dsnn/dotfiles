let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config.allowUnfree = true; };
in pkgs.mkShellNoCC {
  name = "terraform-env";
  packages = with pkgs; [
    terraform
    bind
    dig
    terraform-providers.null
    terraform-providers.external
  ];
}
