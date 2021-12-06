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

### wsl 
- xrdp

### zsh 
- spaceship-prompt

### makefile
- general script to fetch/update from latest 
  - nvim (already working w/ lazy script)
  - lazygit 
  - z

### nvim

- lua snippets, formating etc
- telescope:
  - cheat ?
  - git actions ?
- autocommand to remove trailing spaces
- lsp qf d.ts fix
- turbo console log lua command / script
- vim-dadbod
- tabnine nvim-cmp (?)
- vsts integration (bleh)

### plugins

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
- L3MON4D3/LuaSnip - to replace hrsh7th/vim-vsnip ?
  - rafamadriz/friendly-snippets ?
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
- https://github.com/neovim/nvim-lspconfig
- https://microsoft.github.io/language-server-protocol/implementors/servers/

### dotfiles

- https://github.com/glepnir/nvim
- https://github.com/elianiva/dotfiles
- https://github.com/ahmedelgabri/dotfiles
- https://github.com/tjdevries/config_manager
- https://github.com/ngscheurich/dotfiles
- https://github.com/jesseleite/dotfiles
