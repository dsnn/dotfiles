let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs { config.allowUnfree = true; };
in
pkgs.mkShellNoCC {
  name = "terraform-env";
  packages = with pkgs; [
    terraform
    bind
    dig
    # unstable.terraform
    # unstable.terraform-ls
    terraform-providers.null
    terraform-providers.external
    terranix
  ];
  # generate terraform configuration in json format
  # terranix config.nix > config.tf.json
  # terraform init && terraform apply
}
