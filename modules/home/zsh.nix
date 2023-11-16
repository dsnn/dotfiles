{ pkgs, ... }: {

  # Dependencies
  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
  programs.lsd.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

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
    # path = "/home/dsn/.config/zsh/history";
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
    # LIBGL_ALWAYS_INDIRECT = 1;
  };

  programs.zsh.shellAliases = {
    cat = "bat";
    awk = "nawk";
    tracert = "trip";

    # TODO: OS specific file shortcuts
    # cfc = "vim $HOME/dotfiles/home.nix";
    # cfs = "vim $HOME/.ssh/config";
    # cfz = "vim $HOME/dotfiles/home.nix";
    # cfg = "vim $HOME/dotfiles/home.nix";

    # folder shortcuts
    h = "cd ~/";
    d = "cd ~/dotfiles";
    cf = "cd ~/.config";


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
    # rf = "home-manager switch; source ~/.config/zsh/.zshrc";
    rl = "source ~/.config/zsh/.zshrc";

    # listing
    l="lsd -alh --color=auto";
    la="lsd -alh --color=auto";
    ls="lsd -h --color=auto";
    ll="lsd -alh --color=auto --format=horizontal ";

    # git
    g = "git";
    ga = "git add .";
    gc = "git commit -m";
    gd = "git diff";
    gpl = "git pull";
    gl = "git ls";
    gp = "git push origin master";
    gpf = "git push --force-with-lease";
    gs = "git st";
    cb = "git cb";
    gam = "git commit --amend --no-edit";
    lzg = "lazygit";

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

    # TODO: source $HOME/.config/zsh/exports

    # starship  prompt
    if command -v starship &> /dev/null
    then
      eval "$(starship init zsh)"
    fi

    # 1password shell completions
    if command -v op &> /dev/null
    then
      eval "$(op completion zsh)"; compdef _op op
    fi

    [ -f ~/.ssh/id_rsa ] && eval $(keychain --eval --quiet --quick id_rsa ~/.ssh/id_rsa)
    [ -f ~/.secrets/exports.secret ] && source ~/.secrets/exports.secret

    ######### EXPORTS #########

    # PATH
    [ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
    [ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

    # XDG
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_CACHE_HOME="$HOME/.local/cache"

    # volta
    export VOLTA_HOME="$HOME/.config/volta"
    export PATH="$VOLTA_HOME/bin:$PATH"

    # fzf
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'	
    export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
    export FZF_ALT_C_COMMAND="fd -t d . $HOME"
    export FZF_COMPLETION_OPTS='+c -x'

    # ansible
    export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault-password
    
    # tmuxp
    TMUXP_CONFIGDIR=$HOME/.config/tmuxp
    
    # nvim
    export PATH="$HOME/.local/bin/nvim/bin:$PATH"
    
    # npm
    PATH="$PATH:$HOME/.node_modules/bin"
    export npm_config_prefix=~/.node_modules
    
    # yarn
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
    
    # colored man pages
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;38;5;74m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[38;33;246m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[04;38;5;146m'
  '';

}
