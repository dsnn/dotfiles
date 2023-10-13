
setopt autocd 
setopt extendedglob

# autosuggestions
# autoload -Uz compinit
# compinit

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit -i
fi


# history
HISTFILE=~/.config/zsh/history
HISTSIZE=10000
SAVEHIST=10000
HIST_IGNORE_DUPS=true
SHARE_HISTORY=true

source ~/.config/zsh/aliases
source ~/.config/zsh/exports
source ~/.config/zsh/keybindings

# starship prompt
eval "$(starship init zsh)"

# 1password shell completions
if command -v op &> /dev/null
then
  eval "$(op completion zsh)"; compdef _op op
fi

[ -f ~/.ssh/id_rsa ] && eval $(keychain --eval --quiet --quick id_rsa ~/.ssh/id_rsa)
[ -f ~/.secrets/exports.secret ] && source ~/.secrets/exports.secret

# [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
# [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
# [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $(brew --prefix)/share/zsh-syntax-highlighting.zsh ] && source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
