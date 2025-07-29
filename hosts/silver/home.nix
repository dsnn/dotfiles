{
  config,
  hostname,
  ...
}:
{
  programs.zsh.initContent = ''
    function run_nvim() {
      BUFFER="nvim && clear"
      zle accept-line
    }
    zle -N run_nvim
    bindkey "^n" run_nvim
  '';

  dsn = {
    bottom.enable = true;
    dircolors.enable = false;
    git.enable = true;
    just.enable = true;
    karabiner.enable = true;
    keychain.enable = true;
    lazygit.enable = true;
    shell.enable = true;
    sops.enable = true;
    ssh.enable = true;
    tmux.enable = true;
    tmuxp.enable = true;
    volta.enable = true;
    wget.enable = true;
    xdg.enable = true;
    xresources.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "dsn";
    homeDirectory = "/Users/dsn";
    stateVersion = "25.05";
    file."${config.home.homeDirectory}/.hushlogin".text = "";
    sessionVariables.NIXD_FLAGS = "-log=error";
    file."${config.home.homeDirectory}/.inputrc".text = ''
      set show-all-if-ambiguous on
      set completion-ignore-case on
      set mark-directories on
      set mark-symlinked-directories on
      set match-hidden-files off
      set visible-stats on
      set keymap vi
      set editing-mode vi-insert
    '';
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zsh.shellAliases = {
      cfc = "vim $HOME/dotfiles/hosts/${hostname}/default.nix";
      cfg = "vim $HOME/dotfiles/modules/home/git.nix";
      cfh = "vim $HOME/dotfiles/profiles/dsn.nix";
      cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
      rf = "home-manager switch --flake ~/dotfiles/#${hostname}; source ~/.config/zsh/.zshrc";
      rs = "sudo darwin-rebuild switch --flake ~/dotfiles/#${hostname}";
      ru = "pushd ~/dotfiles; nix flake update; rf; popd";
    };
  };
}
