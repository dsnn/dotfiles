# dotfiles

```zsh
sudo apt install make
cd ~/dotfiles
make install
tmux: ctrl+a ctrl+I to install tmux packages
```

### font config

```
ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf $XDG_CONFIG_HOME/fontconfig/conf.d
```

### bat

```
sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep
```

### nvim

- telescope:
  - cheat: work db connection strings. submodules etc.
- check nvim-terminal bindings
- autocommand to remove trailing spaces
- spell/spellcheck
- neovim session managment (keybindings, autocmds etc)
- neovim-remote (open files from :term witout nesting)
- remove so lsp gd doesnt open up a quickfix (gD/gd) ?
- add binding for sending telescope response to lsp trouble (e.g c-t)
- fix statusline 'v' (warnings?)
- own fn to insert 'console.log()' w/o current selection
  - own plugin and make use of treesitter (place log before return, outside fn args etc) ?
- review lir, treesitter -textobjects and -refactor
- review spaceship-prompt

### plugins

- tpope/vim-scriptease -- :Message
- pearofducks/ansible-vim
- iamcco/markdown-preview.nvim
- brooth/far.vim -- find and replace
- tpope/vim-repeat
- Shatur95/neovim-session-manager
- ThePrimeagen/harpoon
- nvim-telescope/telescope-freccncy.nvim
- nvim-telescope/telescope-cheat.nvim'
- nvim-telescope/telescope-arecibo.nvim
- tjdevries/astronauta.nvim
- phaazon/hop.nvim -- to replace unblevable/quick-scope ?
- TimUntersberger/neogit
- norcalli/snippets.nvim -- to replace hrsh7th/vim-vsnip ?
- lewis6991/gitsigns.nvim
- https://github.com/tamago324/lir.nvim
- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
- https://github.com/nvim-treesitter/nvim-treesitter-refactor

### links

- https://github.com/nvim-telescope/telescope.nvim/wiki
- https://github.com/dandavison/delta
- https://github.com/awesomeWM/awesome/issues/1395
- https://github.com/jesseduffield/lazygit
- https://github.com/jesseduffield/lazydocker
- https://github.com/jesseduffield/lazynpm
- https://github.com/spaceship-prompt/spaceship-prompt

### dotfiles

- https://github.com/glepnir/nvim
- https://github.com/elianiva/dotfiles
- https://github.com/ahmedelgabri/dotfiles
- https://github.com/tjdevries/config_manager
- https://github.com/ngscheurich/dotfiles
- https://github.com/jesseleite/dotfiles
