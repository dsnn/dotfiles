{ pkgs, config, lib, ... }: {

  imports = [
    ../../modules/home/tmux.nix
    ../../modules/home/git.nix
    ../../modules/home/lazygit.nix
    ../../modules/home/starship.nix
    ../../modules/home/zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # nix.package = pkgs.nixUnstable;

  home.packages = with pkgs; [
    docker-compose
    # _1password-gui
    _1password
    ansible
    ansible-lint
    cksfv
    curl
    direnv
    fd
    freerdp
    gnused
    htop
    jq
    keychain
    mosh
    nawk
    nixfmt
    nixpkgs-fmt
    packer
    ripgrep
    rnix-lsp
    unzip
    vim
    volta
    wakeonlan
    wget
    xclip
    neovim
    kitty
    # discord
    # feh
    # google-chrome
    # slack
    # spotify
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  home.stateVersion = "23.11";
  home.username = "dsn";
  home.homeDirectory = "/Users/dsn";

  xdg.enable = true;

  programs.zsh.shellAliases = {
    rs = "darwin-rebuild switch --flake ~/dotfiles/#macbook";
    rf = "home-manager switch --flake ~/dotfiles/#macbook; source ~/.config/zsh/.zshrc";
    ru = "pushd ~/dotfiles; nix flake update; nixswitch; popd";
    cfc = "vim $HOME/dotfiles/hosts/macbook/configuration.nix";
    cfh = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
    cfs = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfg = "vim $HOME/dotfiles/modules/home/git.nix";
  };
  programs.zsh.history.path = "/Users/dsn/.config/zsh/history";

  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_rsa
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';

  # fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;

  home.file.".hushlogin".text =  "";
  home.file.".inputrc".source = ../../modules/home/inputrc;
  home.file.".config/dircolors".source = ../../modules/home/dircolors;
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ../../modules/home/nvim;
  };

  xdg.configFile."karabiner" = {
    source = config.lib.file.mkOutOfStoreSymlink ../../modules/home/karabiner;
  };

}
