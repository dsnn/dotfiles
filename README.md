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

- [ ] LSP
	- [ ] markdown lint / lsp / snippets / preview
	- [ ] lsp, typechecks, linters
	- [ ] unzip (required by lua lsp server)
	- [X] Add `if has wsl: let s:clip = '/mnt/c/Windows/System32/clip.exe' (or win32yank)`
		- issue: https://github.com/neovim/neovim/issues/13436 (I get: 'could not convert lua table')
- [] Telescope
	- [ ] cheat.sh (https://github.com/nvim-telescope/telescope-cheat.nvim)
		- regex, work stuff (e.g. db connection strings. submodule)
	- [ ] telescope-arecibo
- [ ] fix Bdelete update tab
- [ ] failsafe for aliases (e.g. check if lazygit exists)
- [ ] fix goyo
- [ ] telescope grep w/ presist search word and result (search, then toggle between buffer and result)
- [ ] Fix spellcheck (markdown)
- [ ] shellcheck
- [ ] ueberzug
- [ ] ripgrep - error w/ batcat, tmp fix: `sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep`
- [ ] pynvim
- [ ] neovim-remote (open files from :term witout nesting)
- [ ] change mappings for resizing windows (using C-Arrow atm)
- [ ] lua keymap dsl: https://github.com/tjdevries/astronauta.nvim
- [ ] vim which key (bind to e.g. space + char ?)
- [ ] pandoc
- [ ] latex support
- [ ] omnisharp
- [ ] neovim session managment (keybindings, autocmds etc)
- [ ] vimwiki
	- readme
	- todos
	- notes for home / work (submodule) ?
	- eleventy (submodule) ?
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

## Links

- https://github.com/jesseleite/dotfiles/tree/master/vim
- https://github.com/ngscheurich/dotfiles/tree/main/nvim/.config/nvim
- https://github.com/rafamadriz/friendly-snippets
