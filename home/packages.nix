{ pkgs, isServer, ... }:
with pkgs;
[
  ansible
  ansible-lint
  curl
  fd
  gnused
  htop
  jq
  mosh
  nawk
  neovim
  nil
  nixd
  nixfmt
  nixpkgs-fmt
  packer
  ripgrep
  rnix-lsp
  unzip
  vim
  wakeonlan
  xclip
  # sstp
] ++ pkgs.lib.optionals isServer [ _1password ]

