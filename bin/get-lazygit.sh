#!/bin/bash

# go to local bin
LOCAL_BIN="$HOME/.local/bin"
cd $LOCAL_BIN 

# download latest version of lazygit
LATEST_RELEASE_URL=$(curl -L -s https://github.com/jesseduffield/lazygit/releases/latest | grep -o -E "/(.*)lazygit_(.*)_Linux_x86_64.tar.gz")
URL="https://github.com${LATEST_RELEASE_URL}"
wget $URL

# create folder
mkdir -p lazygit

# extract tar
FILE_NAME=$(basename $URL)
tar -zxf $FILE_NAME --directory $HOME/.local/bin/lazygit

# cleanup
rm -f $FILE_NAME

echo "Lazygit updated!"
