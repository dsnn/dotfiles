{ pkgs, ... }: {

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.dotDir = ".config/zsh";
  programs.zsh.autocd = true;
  # programs.zsh.completionInit = "autoload -Uz compinit";
  programs.zsh.history = {
    size = 10000;
    save = 10000;
    ignoreDups = true;
    share = true;
    extended = true;
  };

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
    VISUAL = "nvim";
    EDITOR = "nvim";
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

    # npm
    ns = "npm start";
    nd = "npm run dev";
    ni = "npm install";
    nt = "npm test";
    ntu = "npm run test:update-snapshot";
    nrt = "npm run typecheck";
    nrl = "npm run lint";

    # wget
    wget = ''wget --hsts-file="$HOME/.config/wget"/wget-hsts'';

    # docker
    ds = "docker ps -a";
    di = "docker images";
    drm = ''docker rm $(docker ps -qa --no-trunc --filter "status=exited")'';
    drmi = "docker rmi $(docker images -q -f dangling=true)";
    # dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
  };

  programs.zsh.initExtra = ''
    # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
    export KEYTIMEOUT=1

    # keychain
    # if [ -f ~/.ssh/id_rsa ]; then
    #   eval $(keychain --eval --quiet --quick id_rsa ~/.ssh/id_rsa)
    # fi

    # enable vi-mode
    bindkey -v

    # keybinding for accepting autosuggestion
    bindkey '^ ' autosuggest-accept

    # edit current command in vim
    autoload -U edit-command-line; zle -N edit-command-line
    bindkey '^e' edit-command-line

    # keybinding for cd ..
    function up_widget() {
      BUFFER="cd .."
      zle accept-line
    }
    zle -N up_widget
    bindkey "^u" up_widget

    # keybinding for nvim
    function run_nvim() {
      BUFFER="nvim && clear"
      zle accept-line
    }
    zle -N run_nvim
    bindkey "^n" run_nvim

    # keybinding for lazy git
    function run_lazy_git() {
      BUFFER="lazygit && clear"
      zle accept-line
    }
    zle -N run_lazy_git
    bindkey "^g" run_lazy_git

    # starship  prompt
    if command -v starship &> /dev/null
    then
      eval "$(starship init zsh)"
    fi

    if command -v direnv &> /dev/null
    then
      eval "$(direnv hook zsh)"
    fi

    # 1password shell completions
    if command -v op &> /dev/null
    then
      eval "$(op completion zsh)"; compdef _op op
    fi

    [ -f ~/.ssh/id_rsa ] && eval $(keychain --eval --quiet --quick id_rsa ~/.ssh/id_rsa)

    ######### EXPORTS #########

    if [ -f "$HOME/.secrets/export.secrets" ]; then
      source $HOME/.secrets/export.secrets
    fi

    # bin
    if [ -d "$HOME/.local/bin" ]; then
      export PATH="$HOME/.local/bin:$PATH"
    fi

    # XDG
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_CACHE_HOME="$HOME/.local/cache"

    # volta
    export VOLTA_HOME="$HOME/.config/volta"
    export PATH="$VOLTA_HOME/bin:$PATH"

    # nvim
    export PATH="$HOME/.local/bin/nvim/bin:$PATH"

    # npm
    PATH="$PATH:$HOME/.node_modules/bin"
    export npm_config_prefix=~/.node_modules
  '';
}
