
setopt autocd 
setopt extendedglob

export KEYTIMEOUT=1 # Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
bindkey -v

zstyle :compinstall filename '$HOME/.zshrc'

# Needs to loaded in order else shell will output "maximum nested function level reached"
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fi

# load autosuggestions
autoload -Uz compinit
compinit

# history
HISTFILE=~/.config/zsh/history
HISTSIZE=10000
SAVEHIST=10000
HIST_IGNORE_DUPS=true
SHARE_HISTORY=true

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

# source aliases
if [ -f ~/.config/zsh/aliases ]; then
	source ~/.config/zsh/aliases
fi

# source exports
if [ -f ~/.config/zsh/exports ]; then
	source ~/.config/zsh/exports
fi

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
eval "$(starship init zsh)"

if command -v setxkbmap > /dev/null && command -v xcape /dev/null; then
  setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Caps_Lock=Escape' &
fi 


# POWERLINE_BASH_SELECT=1
# . /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh
# autoload -Uz promptinit
# promptinit
# prompt suse

# keychain
if [ -f ~/.ssh/id_rsa ]; then
	eval $(keychain --eval --quiet --quick id_rsa ~/.ssh/id_rsa)
fi

# Suggestions
bindkey '^ ' autosuggest-accept
# # Accepts the current suggestion.
#  autosuggest-accept: 
# # Accepts and executes the current suggestion.
# autosuggest-execute: 
# # Clears the current suggestion.
# autosuggest-clear: 
# # Fetches a suggestion (works even when suggestions are disabled).
# autosuggest-fetch: 
# # Disables suggestions.
# autosuggest-disable: 
# # Re-enables suggestions.
# autosuggest-enable: 
# # Toggles between enabled/disabled suggestions.
# autosuggest-toggle: 

# color overrides
# https://github.com/zsh-users/zsh-syntax-highlighting

# ZSH_HIGHLIGHT_STYLES[default]='none'
# ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
# ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
# ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[precommand]='none'
# ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
# ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[path]='none'
# ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
# ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
# ZSH_HIGHLIGHT_STYLES[globbing]='fg=green'
# ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[assign]='none'
