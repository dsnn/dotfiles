# dotfiles

- some nix, gymnastics and dotfiles installation
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
    home-manager switch
    command -v zsh | sudo tee -a /etc/shells
    sudo chsh -s "$(command -v zsh)" "${USER}"
    ```

### nix
- convert to flakes / imports 
    - combine nvim and plugins?
      w/ this everything gets updated to latest at the same time

### wsl 
- xrdp (?)

### nvim

- review completion, snippets & tabnine
- review telescope: lsp, cheat & git actions 
- fix lua: snippets (L3MON4D3/LuaSnip), formatting (use https://github.com/JohnnyMorganz/StyLua & create augroup/autocmd bufprewrite .lua)
- fix automically remove trailing spaces (create augroup/autocmd bufprewrite any file)
- fix lsp quickfix d.ts
- fix console.log command (log cword)
- fix nvim-cmp vsts integration 
- fix prettier format scroll to bottom: https://github.com/prettier/vim-prettier/issues/248

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
