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
- firefox (config styles & extensions)
- wsl xrdp (?)
- erase your darlings (rpool/local/root@blank)

### awesomewm
- [fix fn-keys](https://pavelmakhov.com/2016/06/awesome-wm-fn-keys/)
- top & bottom bar
- statusbar 
  - web
  - dev
  - im
  - icons
    - memory current ip volume calendar clock battery filesystem (free/total hdd)
    - power cpu/load wifi vpn ping/speed (speedtest) temp weather mail
  - apps
    - firefox discord teamspeak vs(code) terminal screenshot spotify notion todoist
    - vpn (wireguard openvpn sstp)

### zsh
- review [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode)

### tmux
- review tmux (replace win terminal and kitty)
- review tmux resurrect
- review navigation bindings (w/o prefix)
- review telescope tmux integration
- review keybindings for navigation between windows, panes and nvim splits

### nvim

- treesitter textobjects (select, swap).
- telescope file browser shortcut mappings (home, dotfiles) 
- fix ugly borders in windows terminal (due to font/Roboto NF)
- review local work config (runtimepath)
- [fix prettier](https://github.com/prettier/vim-prettier/issues/248)
- [review telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim)

### plugins

- TimUntersberger/neogit
- [comment](https://github.com/numToStr/Comment.nvim)

### links

- [sops-nix](https://github.com/Mic92/sops-nix#deploy-example)
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
- [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles)
