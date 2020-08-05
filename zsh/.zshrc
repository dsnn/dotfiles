setopt autocd 
setopt extendedglob
bindkey -v

zstyle :compinstall filename '$HOME/.zshrc'

# Needs to loaded in order else shell will output "maximum nested function level reached"
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]; then
	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi

if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]; then
	source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fi

# load autosuggestions
autoload -Uz compinit
compinit

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# POWERLINE_BASH_SELECT=1
# . /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh
autoload -Uz promptinit
promptinit
prompt suse

# source aliases
if [ -f ~/.aliases.zsh ]; then
	source ~/.aliases.zsh
fi

# source exports
if [ -f ~/.exports.zsh ]; then
	source ~/.exports.zsh
fi

# source shortcuts
if [ -f ~/.shortcuts.zsh ]; then
	source ~/.shortcuts.zsh
fi

# keychain
if [ -f ~/.ssh/id_rsa ]; then
	eval $(keychain --eval --quiet --quick id_rsa ~/.ssh/id_rsa)
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# On dir automatic scrpit execution
# function chpwd () {
# 	case $PWD in ~/dotfiles)
# 		check_dotfiles
# 	esac
# }

# Auto check dotfiles
function check_dotfiles() {
		echo "Checking dotfiles, please wait..."
		git fetch --quiet
		if [ $(git rev-list HEAD...origin/master | wc -l) = 0 ]
		then
			pending=$(git diff --numstat HEAD~ | wc -l)
			if [ pending > 0 ]
			then
				echo "Dotfiles up to date with origin. But $pending changes pending"
		  else 
				echo "Dotfiles up to date with origin."
		  fi
		else
			echo "Dotfiles updates detected"
		fi
}

# Keybindings

# up
function up_widget() {
	BUFFER="cd .."
	zle accept-line
}
zle -N up_widget
bindkey "^u" up_widget

# git
function git_prepare() {
	if [ -n "$BUFFER" ];
		then
			BUFFER="git add -A && git commit -m \"$BUFFER\" && git push"
	fi

	if [ -z "$BUFFER" ];
		then
			BUFFER="git add -A && git commit -v && git push"
	fi
			
	zle accept-line
}
zle -N git_prepare
bindkey "^g" git_prepare

# Suggestions
# https://github.com/zsh-users/zsh-autosuggestions 
bindkey '^ ' autosuggest-accept

# Syntax highlighting 
# https://github.com/zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=green'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[assign]='none'
