#!/bin/bash

# go to local bin
LOCAL_BIN="$HOME/.local/bin"
cd $LOCAL_BIN 

# download latest version of lazygit
LATEST=$(curl -L -s https://github.com/neovim/neovim/releases/latest | grep -o -E "/(.*)nvim-linux64.tar.gz")
URL="https://github.com${LATEST}"

# download package
wget $URL

# prepare folder
mkdir -p lazygit

# extract name & tar
FILE_NAME=$(basename $URL)
tar -zxf $FILE_NAME --directory $HOME/.local/bin/nvim

# cleanup
rm -f $FILE_NAME

echo "NVIM updated!"
