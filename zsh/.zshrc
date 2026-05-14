typeset -U path cdpath fpath manpath
# for profile in ${(z)NIX_PROFILES}; do
#   fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
# done

# HELPDIR="/nix/store/i8c3lvyjcciljizv5bbign9rgfkzk0fh-zsh-5.9/share/zsh/$ZSH_VERSION/help"

autoload -U compinit && compinit
# source /nix/store/nk22gl93k4j04b7h3as62bnga9sddxsj-zsh-autosuggestions-0.7.1/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.

# ---------------------- #
#         history        #
# ---------------------- #

HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="/home/dsn/.config/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt autocd

# make vi mode transitions faster
export KEYTIMEOUT=1

# vi mode
bindkey -v

# ---------------------- #
#         fzf            #
# ---------------------- #

if [[ $options[zle] = on ]]; then
  source <(fzf --zsh)
fi

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_TMUX_OPTS="-p80%,60%"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"

export FZF_DEFAULT_OPTS="
--color=bg:#1e1e2e
--color=bg+:#313244
--color=fg:#cdd6f4
--color=header:#f38ba8
--color=hl:#f38ba8
--color=info:#cba6f7
--color=pointer:#f5e0dc
--color=spinner:#f5e0dc
"

export FZF_CTRL_T_OPTS="
--preview 'bat -n --color=always {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'
"

export FZF_ALT_C_OPTS="
--preview 'tree -C {}'
"

export FZF_CTRL_R_OPTS="
--preview 'echo {}'
--preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'
"


# ---------------------- #
#         zoxide         #
# ---------------------- #

eval "$(zoxide init zsh)"

# ---------------------- #
#         volta          #
# ---------------------- #

# VOLTA_HOME="/Users/dsn/.config/volta"
# mkdir -p "$(dirname "$VOLTA_HOME")"
# export $VOLTA_HOME
# export PATH="$VOLTA_HOME/bin:$PATH"
# 
# PATH="$PATH:/Users/dsn/.node_modules/bin"
# export npm_config_prefix=~/.node_modules

# ---------------------- #
#         dotnet         #
# ---------------------- #

# export dotnet-ef for migrations
# export PATH="$PATH:/Users/dsn/.dotnet/tools"

# export for work
# export TEMP='/Users/dsn/projects/work/repos'
# export PATH="/usr/local/share/dotnet:$PATH"

# ---------------------- #
#          accept        #
# ---------------------- #

# ctrl + space to accept
bindkey '^ ' autosuggest-accept
bindkey '^Y' autosuggest-accept

# ---------------------- #
#        extract         #
# ---------------------- #

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip3 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ---------------------- #
#      fn bindings       #
# ---------------------- #

autoload -U edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

run-cd-command () { BUFFER="cd .."; zle accept-line }
zle -N run-cd-command
bindkey '^u' run-cd-command

# ---------------------- #
#      1Password         #
# ---------------------- #

if command -v op &> /dev/null
then
  eval "$(op completion zsh)"; compdef _op op
fi

# ---------------------- #
#         plugins        #
# ---------------------- #

# source /nix/store/vvfsgfiq4566hl41fj7qdp0wqvkx6g2w-zsh-fzf-tab-1.2.0/share/fzf-tab/fzf-tab.plugin.zsh

# ---------------------- #
#         vivid          #
# ---------------------- #

# export LS_COLORS="$(vivid generate catppuccin-mocha)"

# ---------------------- #
#         sesh           #
# ---------------------- #

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# ---------------------- #
#        neovim          #
# ---------------------- #

# ctrl + n to open nvim
function run_nvim() {
  BUFFER="nvim && clear"
  zle accept-line
}
zle -N run_nvim
bindkey "^n" run_nvim

# ---------------------- #
#        lazygit         #
# ---------------------- #

function run_lazy_git() {
  BUFFER="lazygit && clear"
  zle accept-line
}
zle -N run_lazy_git
bindkey "^g" run_lazy_git

# ---------------------- #
#        justfile        #
# ---------------------- #

export JUST_UNSTABLE=1

# ---------------------- #
#        keychain        #
# ---------------------- #

if command -v keychain >/dev/null; then
  eval "$(keychain --eval --quiet id_ed25519)"
fi

# ---------------------- #
#        starship        #
# ---------------------- #

if [[ $TERM != "dumb" ]]; then
  eval "$(starship init zsh)"
fi

# ---------------------- #
#        aliases         #
# ---------------------- #

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias h='cd ~/'
alias cd..='cd ..'
alias cf='cd ~/.config'
alias cfg='nvim $HOME/dotfiles/git/config'
alias cfp='cd ~/projects/'
alias cfz='nvim $HOME/dotfiles/zsh/.zshrc'
alias cp='cp -v'
alias d='cd ~/dotfiles'
alias df='df -h'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias rl='source ~/.config/zsh/.zshrc'
alias -- cat=bat
# alias lpath='echo $PATH | tr '\'':'\'' '\''

# lsd
alias l='lsd -lA --group-dirs=first'
alias la='lsd -A'
alias ll='lsd -l'
alias lla='lsd -lA'
alias lls='lsd -lA --total-size'
alias llt='lsd -l --tree' '\'''
alias lso='lsd -lA --group-dirs=first --permission=octal'
alias lst='lsd -lAt'
alias lt='lsd --tree'
alias ltr='lsd -lA --tree'
alias ls=lsd

# awk
alias awk=nawk

# git
# alias -- churn='!f() { git log --all -M -C --name-only --format='\''format:'\'' "$@" | sort | grep -v '\''^$'\'' | uniq -c | sort | awk '\''BEGIN {print "count    file"} {print $1 "  " $2}'\'' | sort -g; }; f'
alias day='!sh -c '\''git log --reverse --no-merges --branches --date=iso --after="yesterday 23:59" --author="`git config --get user.name`"'\'''
alias delete-merged-branches='!f() { git checkout --quiet master && git branch --merged | grep --invert-match '\''\*'\'' | xargs -n 1 git branch --delete; git checkout --quiet @{-1}; }; f'
alias g="git"
alias ga="git add ."
alias gc="git commit -m"
alias gd="git diff"
alias gpl="git pull"
alias gl="git ls"
alias gp="git push origin master"
alias gpf="git push --force-with-lease"
alias gs="git st"
alias cb="git cb"
alias gam="git commit --amend --no-edit"
alias lzg="lazygit"

# docker
alias di='docker images'
alias drm='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'
alias drmi='docker rmi $(docker images -q -f dangling=true)'
alias ds='docker ps -a'

# du
alias dud='du --max-depth=1 --human-readable'
alias duf='du --summarize --human-readable *'
alias j=just

# npm
# alias -- nd='npm run dev'
# alias -- ni='npm install'
# alias -- nrl='npm run lint'
# alias -- nrt='npm run typecheck'
# alias -- ns='npm start'
# alias -- nt='npm test'
# alias -- ntu='npm run test:update-snapshot'

alias rl='source ~/.config/zsh/.zshrc'

# trash
# alias -- rm=trash-put
# alias -- rmd=trash-put

# sesh
alias s='sesh connect $(sesh list --icons | fzf --ansi)'

# tracert
alias tracert=trip

# alias -g -- CA='2>&1 | cat -A'
# alias -g -- G='| grep'
# alias -g -- H='| head'
# alias -g -- L='| less'
# alias -g -- LL='2>&1 | less'
# alias -g -- M='| most'
# alias -g -- NE='2> /dev/null'
# alias -g -- NUL='> /dev/null 2>&1'
# alias -g -- P='2>&1| pygmentize -l pytb'
# alias -g -- T='| tail'

# source /nix/store/5sz7nq1fa9xm5qmr4bykqcf9cz9b9gkf-zsh-syntax-highlighting-0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ZSH_HIGHLIGHT_HIGHLIGHTERS+=()
