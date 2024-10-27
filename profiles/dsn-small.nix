{ lib, config, ... }:
{
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];

  imports = [ ../modules/home/nixvim ];

  dsn = {
    packages = {
      enable = true;
      enable-dev-tools = false;
    };
    bat.enable = true;
    bottom.enable = true;
    dircolors.enable = true;
    fzf.enable = true;
    git.enable = true;
    inputrc.enable = true;
    # keychain.enable = false;
    # lazygit.enable = false;
    lsd.enable = true;
    # nvim.enable = false;
    ssh.enable = true;
    starship.enable = true;
    # tmux.enable = false;
    # tmuxp.enable = false;
    vivid.enable = true;
    # volta.enable = false;
    wget.enable = true;
    xdg.enable = true;
    xresources.enable = true;
    zoxide.enable = true;
    # just.enable = false;
    zsh = {
      enable = true;
      enable-docker-aliases = false;
    };
    # sops.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "dsn";
    homeDirectory = lib.mkDefault "/home/dsn"; # required by sops
    stateVersion = "24.05";
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

    # host specific aliases
    zsh.shellAliases = {
      # cfc = "vim $HOME/dotfiles/configs/${hostname}.nix";
      cfg = "vim $HOME/dotfiles/modules/home/git.nix";
      cfh = "vim $HOME/dotfiles/profiles/dsn.nix";
      cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
      # rf = "home-manager switch --flake ~/dotfiles/#${hostname}; source ~/.config/zsh/.zshrc";
      # rs = "${rebuild-command} switch --flake ~/dotfiles/#${hostname}";
      ru = "pushd ~/dotfiles; nix flake update; rf; popd";
    };
  };

}
