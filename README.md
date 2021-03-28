# dotfiles

```zsh
sudo apt install make

cd ~/dotfiles

make install

tmux: ctrl+a ctrl+I to install tmux packages
```

## LSP for nvim 

`npm install --prefix ~/.local/share/nvim/lspinstall/ <pkg1, pkg2>`

```vim
npm i -g bash-language-server \
vscode-css-languageserver-bin \
dockerfile-language-server-nodejs \
graphql-language-service-cli \
vscode-html-languageserver-bin \
typescript typescript-language-server \
vscode-json-languageserver \
vim-language-server \
yaml-language-server \
markdownlint --save-dev
```

## packages

- curl
- fzf
- git
- keychain
- make
- neovim
- nodejs
- npm
- ranger
- silversearcher-ag
- stow
- tmux
- zsh


## TODO

- [ ] review / fix install script for *
	- write bash script for w/e. (make it clean and pretty w/ separate functions for w/e)
	- simple install solution: call script fns from makefile?
- [ ] autoinstall/updates for
    	- automatic daily update (might be "dangerous" or annoying if things break ?)
	    	- on first run for the day ?
		- cron ?
	- lsp-servers 
	- app deps (make install now)
	- nightly build apps (.local/bin)
	- repos / submodules
- [ ] add floaterm w/ lazy*
- [ ] table for nvim plugins 
- [ ] cheat.sh (https://github.com/nvim-telescope/telescope-cheat.nvim)
	- regex
	- work stuff (e.g. db connection strings. submodule)
- [ ] nvim surround plugin
- [ ] markdown lint / lsp / snippets / preview
- [ ] better quickfix win 
    - telescope?
    - lsp, typechecks, linters
- [ ] telescope-arecibo 
- [ ] vim which key (bind to e.g. space + char ?) 
- [ ] fix Bdelete update tab
- [ ] vimwiki 
	- readme
	- todos
	- notes for home / work (submodule) ?
	- eleventy (submodule) ?
- [ ] failsafe for aliases (e.g. check if lazygit exists)
- [ ] shellcheck 
- [ ] ueberzug 
- [ ] fd (aka fd-find)
- [ ] ripgrep - error w/ batcat, tmp fix: `sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep`
- [ ] lazygit
- [ ] lazydocker
- [ ] lazynpm
- [ ] pynvim
- [ ] neovim-remote (open files from :term witout nesting)
- [ ] pandoc
- [ ] latex support
- [ ] omnisharp
- [ ] unzip (required by lua lsp server)
