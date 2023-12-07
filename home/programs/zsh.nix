{ config, ... }: {

  home.file."${config.home.homeDirectory}/.secrets/export.secrets".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/home/secrets/export.secrets";

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.dotDir = ".config/zsh";
  programs.zsh.autocd = true;
  programs.zsh.history = {
    size = 10000;
    save = 10000;
    ignoreDups = true;
    share = true;
    extended = true;
  };
  programs.zsh.history.path =
    "${config.home.homeDirectory}/.config/zsh/history";
  programs.zsh.sessionVariables = {
    LC_CTYPE = "en_US.UTF-8";
    LEDGER_COLOR = "true";
    LESS = "-FRSXM";
    LESSCHARSET = "utf-8";
    PAGER = "less";
    PROMPT = "%m %~ $ ";
    PROMPT_DIRTRIM = "2";
    RPROMPT = "";
    TERM = "xterm-256color";
    TINC_USE_NIX = "yes";
    WORDCHARS = "";
    BROWSER = "chrome";
    MANWIDTH = 79;
  };

  programs.zsh.shellAliases = {
    awk = "nawk";
    tracert = "trip";

    # folder shortcuts
    h = "cd ~/";
    d = "cd ~/dotfiles";
    cf = "cd ~/.config";
    cfp = "cd ~/projects/";

    # navigation
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "-- -" = "cd ~";
    "cd.." = "cd ..";

    # actions
    mv = "mv -v";
    rm = "rm -i -v";
    rmd = "rm -rf";
    cp = "cp -v";
    df = "df -h";
    mkdir = "mkdir -pv";
    rl = "source ~/.config/zsh/.zshrc";

    # nix
    bir = "nix repl";
    biu = "nix run";
    bii = "nix-instansiate";
    bis = "nix shell";
  };

  programs.zsh.initExtra = ''
    # make vi mode transitions faster
    export KEYTIMEOUT=1

    # enable vi-mode
    bindkey -v

    bindkey '^ ' autosuggest-accept

    autoload -U edit-command-line; zle -N edit-command-line
    bindkey '^e' edit-command-line

    run-tmux-command () { t; zle redisplay }
    zle -N run-tmux-command
    bindkey '^f' run-tmux-command

    run-cd-command () { BUFFER="cd .."; zle accept-line }
    zle -N run-cd-command
    bindkey '^u' run-cd-command

    if [ -f "$HOME/.secrets/export.secrets" ]; then
      source $HOME/.secrets/export.secrets
    fi
  '';
}
