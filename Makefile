SHELL := /bin/bash

# The directory of this file
DIR := $(shell echo $(shell cd "$(shell  dirname "${BASH_SOURCE[0]}" )" && pwd ))

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

install: ## install packages 
	sudo apt install git zsh fzf neovim nodejs keychain tmux stow silversearcher-ag fd-find
stow: ## stow packages 
	stow git
	mkdir -p ~/bin
	stow bin -t ~/bin
	stow tmux
	mkdir -p ~/.config/nvim
	stow vim -t ~/.config
	stow zsh



