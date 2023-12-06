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
  packer
  unzip
  vim
  wakeonlan
  xclip
  # sstp

  # neovim
  # nodePackages."bash-language-server"
  # nodePackages."diagnostic-languageserver"
  # nodePackages."dockerfile-language-server-nodejs"
  # nodePackages."pyright"
  # nodePackages."typescript"
  # nodePackages."typescript-language-server"
  # nodePackages."vscode-langservers-extracted"
  # nodePackages."yaml-language-server"
  # omnisharp-roslyn
  # terraform
  # terraform-ls
  fd
  lazydocker
  lua-language-server
  nil
  nil
  nixd
  nixfmt
  nixpkgs-fmt
  ripgrep
  rnix-lsp
  shfmt
# dotnet-sdk_8
] ++ pkgs.lib.optionals isServer [
  _1password
]

# TODO: packages: install fonts
# [
#   (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
# ];
