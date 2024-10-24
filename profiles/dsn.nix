{
  config,
  pkgs,
  hostname,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
  rebuild-command = if isDarwin then "darwin-rebuild" else "sudo -H nixos-rebuild";
in
{

  # Fix home manager for non NixOS
  # targets.genericLinux.enable = true;

  dsn = {
    packages = {
      enable = true;
      enable-dev-tools = true;
    };
    bat.enable = true;
    bottom.enable = true;
    dircolors.enable = true;
    fzf.enable = true;
    git.enable = true;
    inputrc.enable = true;
    karabiner.enable = true;
    keychain.enable = true;
    kitty.enable = true;
    lazygit.enable = true;
    lsd.enable = true;
    nvim.enable = true;
    ssh.enable = true;
    starship.enable = true;
    tmux.enable = true;
    tmuxp.enable = true;
    vivid.enable = true;
    volta.enable = true;
    wget.enable = true;
    xdg.enable = true;
    xresources.enable = true;
    zoxide.enable = true;
    zsh = {
      enable = true;
      enable-docker-aliases = false;
    };
    sops.enable = true;
  };

  home.sessionVariables.NIXD_FLAGS = "-log=error";

  # scripts.enable = true;
  # imports = lib.concatMap import [
  #   ../modules/home
  #   ../modules/home/scripts
  #   ../modules/home/secrets
  # ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "dsn";
    homeDirectory = if isDarwin then "/Users/dsn" else "/home/dsn";
    stateVersion = "23.11";
    file."${config.home.homeDirectory}/.hushlogin".text = "";
  };

  home.file."${config.home.homeDirectory}/.inputrc".text = ''
    set show-all-if-ambiguous on
    set completion-ignore-case on
    set mark-directories on
    set mark-symlinked-directories on
    set match-hidden-files off
    set visible-stats on
    set keymap vi
    set editing-mode vi-insert
  '';

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # fonts.fontconfig.enable = true;

  # host specific aliases
  programs.zsh.shellAliases = {
    cfc = "vim $HOME/dotfiles/configs/${hostname}.nix";
    cfg = "vim $HOME/dotfiles/modules/home/git.nix";
    cfh = "vim $HOME/dotfiles/profiles/dsn.nix";
    cfz = "vim $HOME/dotfiles/modules/home/zsh.nix";
    rf = "home-manager switch --flake ~/dotfiles/#${hostname}; source ~/.config/zsh/.zshrc";
    rs = "${rebuild-command} switch --flake ~/dotfiles/#${hostname}";
    ru = "pushd ~/dotfiles; nix flake update; rf; popd";
  };
}
