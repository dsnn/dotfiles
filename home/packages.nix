{ pkgs, isServer, ... }:
with pkgs;
[
  # dotnet-sdk_8
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
  # sstp
  # terraform
  # terraform-ls
  ansible
  ansible-lint
  curl
  fd
  fd
  git-crypt
  gnused
  htop
  jq
  lazydocker
  lua-language-server
  mosh
  nawk
  nil
  nil
  nixd
  nixfmt
  nixpkgs-fmt
  packer
  ripgrep
  rnix-lsp
  shfmt
  unzip
  vim
  wakeonlan
  xclip
  spotify-tui
  proselint
] ++ pkgs.lib.optionals isServer [
  _1password
]

# TODO: packages: install fonts
# [
#   (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
# ];
