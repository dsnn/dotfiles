{ pkgs, isServer, ... }:
with pkgs;
[
  dotnet-sdk_8
  # omnisharp-roslyn
  # sstp
  # terraform
  # terraform-ls
  ansible
  ansible-lint
  curl
  fd
  git-crypt
  gnused
  htop
  jq
  lazydocker
  mosh
  nawk
  gnumake
  cmake
  packer
  ripgrep
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
