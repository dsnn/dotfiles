setopt autocd
setopt extendedglob
bindkey -v

zstyle :compinstall filename '$HOME/.config/zsh/.zshrc'

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
[ -f ~/build/z/z.sh ] && source ~/build/z/z.sh

# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '('$branch')'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Config for prompt. PS1 synonym.
prompt='%2/ $(git_branch_name) > '

# autoload -Uz promptinit
# promptinit
# prompt suse

# source exports
if [ -f ~/.config/zsh/.exports.zsh ]; then
	source ~/.config/zsh/.exports.zsh
fi

# source aliases
if [ -f ~/.config/zsh/.aliases.zsh ]; then
	source ~/.config/zsh/.aliases.zsh
fi


# source local aliases
if [ -f ~/.aliases.local.zsh ]; then
	source ~/.aliases.local.zsh
fi

# source shortcuts
if [ -f ~/.config/zsh/.shortcuts.zsh ]; then
	source ~/.config/zsh/.shortcuts.zsh
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
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=white
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=white
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=white
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none
