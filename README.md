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

manually download and install 
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Lazydocker](https://github.com/jesseduffield/lazydocker)
- [Lazynpm](https://github.com/jesseduffield/lazynpm)

## TODO

- [X] Add `if has wsl: let s:clip = '/mnt/c/Windows/System32/clip.exe' (or win32yank)`
	- issue: https://github.com/neovim/neovim/issues/13436 (I get: 'could not convert lua table')
- [ ] fix highlight for matching words (on hover)
- [ ] add lsp gh command
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
	- lazygit 
	- lazydocker
	- lazynpm
- [ ] cheat.sh (https://github.com/nvim-telescope/telescope-cheat.nvim)
	- regex
	- work stuff (e.g. db connection strings. submodule)
- [ ] markdown lint / lsp / snippets / preview
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
- [ ] Fix spellcheck (markdown)
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
- [ ] run lua line (LuaDev-Runline) 
- [ ] base16 colors
- [ ] exec file cmd: <leader>S cmd luefile %
- [ ] change mappings for resizing windows (using C-Arrow atm)
- [ ] neovim session managment (keybindings, autocmds etc)
- [ ] remove binding for floating terminal? 
	- kinda want ESC to be working inside the term and not escape out of insert mode.
- [ ] rename var with: https://github.com/glepnir/lspsaga.nvim
- [ ] lua keymap dsl: https://github.com/tjdevries/astronauta.nvim

## Links

- https://github.com/jesseleite/dotfiles/tree/master/vim
- https://github.com/ngscheurich/dotfiles/tree/main/nvim/.config/nvim
- https://github.com/rafamadriz/friendly-snippets
