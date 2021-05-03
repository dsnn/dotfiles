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

## AwesomeWM

- [Screenshots](https://github.com/awesomeWM/awesome/issues/1395)

## Arch

- [ ] [XDG Base Directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory)
- [ ] [Qutebrowser](https://wiki.archlinux.org/index.php/Qutebrowser#Installation)

### Font config

```
ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf $XDG_CONFIG_HOME/fontconfig/conf.d
```

## notes

Error w/ batcat, tmp fix: `sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep`

### nvim

  - review plugins in plugins.lua (commented)
  - telescope:
    - git branches checkout
    - window layouts for diff. bindings
  - check nvim-terminal bindings
  - check resize windows
  - autocommand to remove trailing spaces
	- vista: toggle keybinding for listing lsp symbols in a sidebar
  - test harpoon
	- telescope-cheat: E.g. regex, work stuff (e.g. db connection strings. submodule)
	- spell/spellcheck
	- more linting (markdown etc)
	- neovim session managment (keybindings, autocmds etc)
	- lua keymap dsl: https://github.com/tjdevries/astronauta.nvim
	- neovim-remote (open files from :term witout nesting)
  - floatterm
  - lazygit floatterm? (or fugitive)

### plugins

  - windwp/nvim-autopairs
  - tpope/vim-scriptease                           -- :Message
  - pearofducks/ansible-vim
  - iamcco/markdown-preview.nvim
  - liuchengxu/vista.vim
  - brooth/far.vim                                 -- find and replace
  - JoosepAlviste/nvim-ts-context-commentstring    -- better comments (use w/ vim-commentary instead?)
  - tpope/vim-repeat
  - TimUntersberger/neogit                         -- or fugitive?
  - https://github.com/sindrets/diffview.nvim      -- single tab for diffs (or fugitive)
  - https://github.com/Shatur95/neovim-session-manager
  - https://github.com/ThePrimeagen/harpoon

## Links

- https://github.com/jesseleite/dotfiles/tree/master/vim
- https://github.com/ngscheurich/dotfiles/tree/main/nvim/.config/nvim
- https://github.com/rafamadriz/friendly-snippets

