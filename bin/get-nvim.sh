#!/bin/bash

# super lazy script to download and install nightly build of neovim 

cd "$HOME/.local/bin" 

LATEST=https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz

wget "${LATEST}"

PKG_NAME=$(basename $LATEST)

tar -xzf $PKG_NAME 

rm -rf nvim

mv nvim-linux64 nvim

rm -f $PKG_NAME

echo "NVIM updated!"

