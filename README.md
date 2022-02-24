# dotfiles

- random commands for (nix) dotfiles 
    ```
    sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
    curl -L https://nixos.org/nix/install | sh
    source $HOME/.nix-profile/etc/profile.d/nix.sh
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    nix-shell '<home-manager>' -A install
    rm -rf ~/.config/nixpkgs
    git clone https://github.com/dsnn/dotfiles.git
    ln -s ~/dotfiles ~/.config/nixpkgs
    home-manager switch --falke .#
    command -v zsh | sudo tee -a /etc/shells
    sudo chsh -s "$(command -v zsh)" "${USER}"
    ```

### infra
- nix docker host 
- nix k3s

### nix
- nix nvim plugins (pin version?) 
- firefox extensions
- wsl xrdp (?)

### awesomewm
- top & bottom bar (?)
- side menu
- statusbar 
  - web
  - dev
  - im
  - icons
    - memory
    - current ip
    - volume
    - calendar 
    - clock
    - battery
    - filesystem (free/total hdd)
    - power
    - cpu/load
    - wifi 
    - vpn
    - current ping/speed to internet (speedtest)
    - temp
    - weather
  - apps
    - firefox
    - vpn (work/home)
      - wireguard
      - openvpn
      - sstp
    - discord
    - teamspeak
    - vs(code)
    - terminal
    - screenshot
    - spotify
    - notion
    - todoist

### zsh
- review [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode)

### nvim

- review completion, snippets & tabnine
- review telescope: lsp, cheat, browser & git actions 
- fix lua: snippets, formatting (stylua/sumneko?) 
- fix automically remove trailing spaces (bufprewrite)
- [fix prettier](https://github.com/prettier/vim-prettier/issues/248)

### plugins

- tpope/vim-dadbod
- numToStr/Comment
- rcarriga/nvim-notify
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
- phaazon/hop.nvim vs unblevable/quick-scope ?
- TimUntersberger/neogit
- [lir.nvim](https://github.com/tamago324/lir.nvim)
- [treesitter textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [treesitter refactor](https://github.com/nvim-treesitter/nvim-treesitter-refactor)

### links

- [telescope](https://github.com/nvim-telescope/telescope.nvim/wiki)
- [delta](https://github.com/dandavison/delta)
- [awesomewm](https://github.com/awesomeWM/awesome/issues/1395)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [lazydocker](https://github.com/jesseduffield/lazydocker)
- [lazynpm](https://github.com/jesseduffield/lazynpm)
- [spaceship-prompt](https://github.com/spaceship-prompt/spaceship-prompt)
- [lspconfig](https://github.com/neovim/nvim-lspconfig)
- [lsp servers](https://microsoft.github.io/language-server-protocol/implementors/servers/)

### dotfiles

- [gelpnir](https://github.com/glepnir/nvim)
- [elianiva](https://github.com/elianiva/dotfiles)
- [ahmedelgabri](https://github.com/ahmedelgabri/dotfiles)
- [tjdevries](https://github.com/tjdevries/config_manager)
- [ngscheurich](https://github.com/ngscheurich/dotfiles)
- [jesseleite](https://github.com/jesseleite/dotfiles)
