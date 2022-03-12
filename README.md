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

### server 
- docker 
- k3s
- syncthing
- drone
- gitea
- cups
- unifi
- heimdall
- sftp
- backup/rsync

### nix
- nix nvim plugins (pin version?) 
- [firefox (config styles & extensions)](https://nixos.wiki/wiki/Firefox)
- wsl xrdp
- [erase your darlings (rpool/local/root@blank)](https://grahamc.com/blog/erase-your-darlings)
- run mkpasswd & save to sops for [passwordFile](https://nixos.org/manual/nixos/stable/options.html#opt-users.extraUsers._name_.passwordFile)
- [syncthing](https://nixos.wiki/wiki/Syncthing)
- [buildCores](https://nixos.org/manual/nix/stable/advanced-topics/cores-vs-jobs.html)
- [powerManagement.enable?](https://nixos.org/manual/nixos/stable/options.html#opt-hardware.nvidia.powerManagement.enable)
- [hardware.opengl.extraPackages](https://nixos.org/manual/nixos/stable/options.html#opt-hardware.opengl.extraPackages)
  - [Accelerated Video Playback (vaapiIntel)](https://nixos.wiki/wiki/Accelerated_Video_Playback)
- review [git-agecrypt](https://github.com/vlaci/git-agecrypt) for semi-secrets. [See here](https://github.com/Mic92/sops-nix/issues/159)
- kodi settings & addons
- move package installation to the module(s). e.g i3 should install itself and all deps.

### i3 
- autostart (firefox, discord, teamspeak, terminal, spotify)
- fix workspace (starts at 10 for second screen, should be 1 & 2)
- host specific configurations (e.g. xorg.xbacklight for laptop only)
- polybar
  - network manager
    - wireguard /work vpn + rdp
    - [nm-applet](https://github.com/polybar/polybar/issues/1355)
    - [rofi nm](https://github.com/P3rf/rofi-network-manager)
  - fix left-click on date should open gsimplecal (through label action)

### zsh
- review [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode)

### tmux
- review tmux (replace win terminal and kitty)
- review tmux resurrect
- review navigation bindings (w/o prefix)
- review telescope tmux integration
- review keybindings for navigation between windows, panes and nvim splits

### nvim
- review treesitter textobjects (select, swap).
- review local work config (runtimepath)
- fix leader+t default to this readme (if e.g. work/todo.md doesnt exists)
- fix ugly borders in windows terminal (due to font/Roboto NF)
- [telescope file browser shortcut mappings (home, dotfiles)](https://github.com/nvim-telescope/telescope-file-browser.nvim)
- [fix prettier](https://github.com/prettier/vim-prettier/issues/248)

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
