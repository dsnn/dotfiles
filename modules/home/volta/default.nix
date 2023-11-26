{ pkgs, ...}:{

  programs.zsh.initExtra = ''
    export VOLTA_HOME="$HOME/.config/volta"
    export PATH="$VOLTA_HOME/bin:$PATH"

    PATH="$PATH:$HOME/.node_modules/bin"
    export npm_config_prefix=~/.node_modules
  '';

  home.packages = with pkgs; [ volta ];
}
