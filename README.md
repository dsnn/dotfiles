# dotfiles

## TODO

Manually install packages below (not accessible on all distro versions)

- fzf
- bat

```zsh
sudo apt install make

cd ~/dotfiles

make install

tmux: ctrl+a ctrl+I to install tmux packages
```

manually download and install to `~/.local/bin`

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
	- shellcheck
- [ ] config
	- format / formatters
	- fix prettier
	- telescope grep w/ presist search word and result (search, then toggle between buffer and result)
	- Fix spellcheck (markdown)
	- change mappings for resizing windows (using C-Arrow atm)
- [ ] shell 
	- failsafe for aliases (e.g. check if lazygit exists) 
	- ueberzug 
	- ripgrep 
		- error w/ batcat, tmp fix: `sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep`
		- replace fd for less deps. (fzf uses fd atm. eventho fd is better for file searching it should be fine w/ rg) 
- [ ] plugins 
	- omnisharp 
	- neovim session managment (keybindings, autocmds etc)
	- vim which key (bind to e.g. space + char ?) 
	- lua keymap dsl: https://github.com/tjdevries/astronauta.nvim 
	- neovim-remote (open files from :term witout nesting) 
	- fix goyo & limelight
	- telescope: cheat.sh (https://github.com/nvim-telescope/telescope-cheat.nvim)
		- regex, work stuff (e.g. db connection strings. submodule)
	- telescope-arecibo 
	- pynvim
- [ ] vimwiki
	- readme
	- todos
	- notes for home / work (submodule) ?
	- eleventy (submodule) ?
- [ ] review / fix (auto-?) install / updates for *
	- simple install solution: call script fns from makefile?
	- write bash script for w/e. (make it clean and pretty w/ separate functions for w/e)
    	- automatic daily update? 
		- might be "dangerous" or annoying if things break ?
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
