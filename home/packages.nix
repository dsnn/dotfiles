{ pkgs, isServer, ... }:
with pkgs;
[
  dotnet-sdk_8
  # omnisharp-roslyn
  # sstp
  # terraform
  # terraform-ls
  ansible
  curl
  fd
  git-crypt
  gnused
  htop
  jq
  lsof
  lazydocker
  mosh
  nawk
  gnumake
  cmake
  ripgrep
  unzip
  vim
  wakeonlan
  xclip
] ++ pkgs.lib.optionals isServer [
  _1password
]

# TODO: packages: install fonts
# [
#   (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
# ];
