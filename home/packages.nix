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
] ++ pkgs.lib.optionals isServer [
  _1password
]

# TODO: packages: install fonts
# [
#   (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
# ];
