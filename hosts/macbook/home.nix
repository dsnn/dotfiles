{ pkgs, config, lib, ... }: {

  imports = [
    ../../modules/home/git
    ../../modules/home/neovim
    ../../modules/home/karabiner
    ../../modules/home/starship
    ../../modules/home/tmux
    ../../modules/home/zsh
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
    SSH_AUTH_SOCK="/Users/dsn/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };
  home.stateVersion = "23.11";
  home.username = "dsn";
  home.homeDirectory = "/Users/dsn";

  programs.zsh.shellAliases = {
    cfc = "vim $HOME/dotfiles/hosts/macbook/configuration.nix";
    cfg = "vim $HOME/dotfiles/modules/home/git.nix";
    cfh = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfs = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
    rf = "home-manager switch --flake ~/dotfiles/#macbook; source ~/.config/zsh/.zshrc";
    rs = "darwin-rebuild switch --flake ~/dotfiles/#macbook";
    ru = "pushd ~/dotfiles; nix flake update; nixswitch; popd";
  };
  programs.zsh.history.path = "/Users/dsn/.config/zsh/history";

  programs.ssh.enable = true;
  programs.ssh.includes = [ "/Users/dsn/.ssh/config.d/*" ];
  programs.ssh.forwardAgent = true;
  programs.ssh.extraConfig = ''
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';

  programs.home-manager.enable = true;
  programs.dircolors.enable = true;
  programs.keychain.enable = true;

  home.file."/Users/dsn/.hushlogin".text =  "";
  home.file."/Users/dsn/.inputrc".source = ../../modules/home/inputrc;
  home.file."/Users/dsn/.config/dircolors".source = ../../modules/home/dircolors;
  home.file."/Users/dsn/.secrets/export.secrets".source = ../../secrets/export.secrets;
  home.file."/Users/dsn/.ssh/config.d/sshconfig.secrets".source = ../../secrets/sshconfig.secrets;
  home.file."/Users/dsn/.local/bin".source = ../../modules/home/bin;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # discord
    # google-chrome
    # _1password
    ansible
    ansible-lint
    cksfv
    curl
    direnv
    docker-compose
    fd
    freerdp
    gnused
    htop
    jq
    keychain
    kitty
    mosh
    nawk
    neovim
    nixfmt
    nixpkgs-fmt
    packer
    ripgrep
    rnix-lsp
    slack
    spotify
    unzip
    vim
    volta
    wakeonlan
    wget
    xclip
  ];
}
