{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;

  imports = [ ../../modules/home ../../modules/collections/zsh.nix ];

  dotfiles.karabiner.enable = true;
  dotfiles.keychain.enable = true;
  dotfiles.kitty.enable = true;
  dotfiles.neovim.enable = true;
  dotfiles.op.enable = true;
  dotfiles.ssh.enable = true;
  dotfiles.volta.enable = true;
  dotfiles.wget.enable = true;

  # host specific aliases
  programs.zsh.shellAliases = {
    cfc = "vim $HOME/dotfiles/hosts/macbook/configuration.nix";
    cfg = "vim $HOME/dotfiles/modules/home/git.nix";
    cfh = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfs = "vim $HOME/dotfiles/hosts/macbook/home.nix";
    cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
    rf =
      "home-manager switch --flake ~/dotfiles/#macbook; source ~/.config/zsh/.zshrc";
    rs = "darwin-rebuild switch --flake ~/dotfiles/#macbook";
    ru = "pushd ~/dotfiles; nix flake update; rf; popd";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
  home.username = "dsn";
  home.homeDirectory = "/Users/dsn";

  home.file."/Users/dsn/.hushlogin".text = "";
  home.file."/Users/dsn/.inputrc".source = ../../modules/home/inputrc;

  home.packages = with pkgs; [
    # _1password
    # discord
    # google-chrome
    ansible
    ansible-lint
    curl
    fd
    freerdp
    gnused
    htop
    jq
    mosh
    nawk
    neovim
    nil
    nixd
    nixfmt
    nixpkgs-fmt
    packer
    ripgrep
    rnix-lsp
    slack
    spotify
    unzip
    vim
    wakeonlan
    xclip
  ];
}
