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

### nvim

- review completion, snippets & tabnine
- review telescope: lsp, cheat, browser & git actions 
- fix lua: snippets, formatting (stylua/sumneko?) 
- fix automically remove trailing spaces (bufprewrite)
- fix lsp quickfix d.ts
- fix console.log (cword)
- fix prettier (https://github.com/prettier/vim-prettier/issues/248)

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
