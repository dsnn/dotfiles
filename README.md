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
    - git branches checkout
    - window layouts for diff. bindings
    - find files from .git and/or specified folders (path changes and telesope doesnt find anything w/ find files)
	  - cheat: work db connection strings. submodules etc.
  - check nvim-terminal bindings
  - check resize windows
  - autocommand to remove trailing spaces
	- vista: toggle keybinding for listing lsp symbols in a sidebar
  - review lazygit, fugitive and neogit. pick one.
  - binding for formatted paste?
  - test harpoon
	- spell/spellcheck
	- more linting (markdown etc)
	- neovim session managment (keybindings, autocmds etc)
	- lua keymap dsl: https://github.com/tjdevries/astronauta.nvim
	- neovim-remote (open files from :term witout nesting)
  - floatterm
  - lazygit floatterm? (or fugitive)
  - auto create ending tag in .js, .ts etc.
  - auto format w/ prettier (and keybinding for toggle it off?)
  - remove so lsp gd doesnt open up a quickfix (gD/gd)
  - paste shouldnt drop whats been recently yanked

### plugins

  - windwp/nvim-autopairs
  - tpope/vim-scriptease                           -- :Message
  - pearofducks/ansible-vim
  - iamcco/markdown-preview.nvim
  - liuchengxu/vista.vim
  - brooth/far.vim                                 -- find and replace
  - JoosepAlviste/nvim-ts-context-commentstring    -- better comments (use w/ vim-commentary instead?)
  - tpope/vim-repeat
  - TimUntersberger/neogit
  - sindrets/diffview.nvim                         -- single tab for diffs (or fugitive)
  - Shatur95/neovim-session-manager
  - ThePrimeagen/harpoon
  - nvim-telescope/telescope-freccncy.nvim
  - nvim-telescope/telescope-cheat.nvim'
  - nvim-telescope/telescope-arecibo.nvim
  - tjdevries/astronauta.nvim
  - folke/lsp-trouble.nvim
  - voldikss/vim-floaterm 

### links

  - https://github.com/dandavison/delta
  - https://github.com/awesomeWM/awesome/issues/1395
  - https://github.com/jesseduffield/lazygit
  - https://github.com/jesseduffield/lazydocker
  - https://github.com/jesseduffield/lazynpm

### dotfiles

  - https://github.com/glepnir/nvim
  - https://github.com/elianiva/dotfiles
  - https://github.com/ahmedelgabri/dotfiles
  - https://github.com/tjdevries/config_manager
  - https://github.com/ngscheurich/dotfiles
  - https://github.com/jesseleite/dotfiles
