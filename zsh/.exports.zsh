if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/bin/cron" ] ; then
    export PATH="$HOME/bin/cron:$PATH"
fi

if [ -d "$HOME/bin/i3" ] ; then
    export PATH="$HOME/bin/i3:$PATH"
fi

if [ -d "$HOME/bin/polybar" ] ; then
    export PATH="$HOME/bin/polybar:$PATH"
fi

if [ -d "$HOME/bin/tools" ] ; then
    export PATH="$HOME/bin/tools:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

[ -f ~/.exports.local.zsh ] && source ~/.exports.local.zsh

# exports
export BROWSER=google-chrome-stable
export EDITOR=nvim
export VISUAL=nvim
export MANWIDTH=79
# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
# export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1


# fd
export FD_OPTIONS="--follow --hidden --exclude .git --exclude node_modules"

# fzf
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fdfind --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fdfind $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fdfind --type d $FD_OPTIONS . '/'"
export FZF_COMPLETION_OPTS="+c -x"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (cat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='ctrl-v:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy),ctrl-x:execute(rm -i {+})+abort'"

# spaceship prompt (install with npm)
# export SPACESHIP_CHAR_SYMBOL="%{\e[38;5;001m%}•%{\e[38;5;011m%}•%{\e[38;5;004m%}• "

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# npm
PATH="$PATH:$HOME/.node_modules/bin"
export npm_config_prefix=~/.node_modules

# colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'
