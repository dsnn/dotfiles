setopt autocd 
setopt extendedglob

# autosuggestions
# autoload -Uz compinit
# compinit

# history
HISTFILE=~/.config/zsh/history
HISTSIZE=10000
SAVEHIST=10000
HIST_IGNORE_DUPS=true
SHARE_HISTORY=true

source ~/.config/zsh/aliases
source ~/.config/zsh/exports
source ~/.config/zsh/keybindings

# starship  prompt
eval "$(starship init zsh)"

[ -f ~/.ssh/id_rsa ] && eval $(keychain --eval --quiet --quick id_rsa ~/.ssh/id_rsa)
[ -f ~/.secrets/exports.secret ] && source ~/.secrets/exports.secret

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit -i
fi

[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/share/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
