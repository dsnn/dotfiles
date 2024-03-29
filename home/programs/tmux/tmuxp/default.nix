{ config, ... }: {

  # home.packages = with pkgs; [ tmuxp lsof ];
  programs.tmux.tmuxp.enable = true;

  home.file."${config.home.homeDirectory}/.config/tmuxp".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/home/programs/tmux/tmuxp/profiles";

  programs.zsh.initExtra = ''
    export TMUXP_CONFIGDIR=$HOME/.config/tmuxp
  '';
}
