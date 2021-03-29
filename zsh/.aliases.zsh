alias fd='fdfind'

alias vim='/home/dsn/.local/bin/nvim/bin/nvim'
alias nvim='/home/dsn/.local/bin/nvim/bin/nvim'
alias lazygit='/home/dsn/.local/bin/lazygit/lazygit'
alias lazynpm='/home/dsn/.local/bin/lazynpm/lazynpm'
alias lazydocker='/home/dsn/.local/bin/lazydocker/lazydocker'

# file shortcuts
alias cfc="nvim ~/.shortcuts"
alias cfs="nvim ~/.ssh/config"
alias cfv="nvim ~/dotfiles/vim/init.vim"
alias cft="nvim ~/dotfiles/tmux/.tmux.conf"
alias cfe="nvim ~/dotfiles/zsh/.exports.zsh"
alias cfa="nvim ~/dotfiles/zsh/.aliases.zsh"
alias cfz="nvim ~/dotfiles/zsh/.zshrc"
alias cfg="nvim ~/dotfiles/git/.gitconfig"

# folder shortcuts
alias h="cd ~/"
alias s="cd ~/bin"
alias d="cd ~/dotfiles"
alias dev="cd ~/devops"
alias cf="cd ~/.config"
alias pp="cd ~/projects"
alias c="cd /mnt/c/"

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd ~"
alias cd..="cd .."

# actions
alias mv='mv -v'
alias rm='rm -i -v'
alias rmd='rm -rf'
alias cp='cp -v'
alias df="df -h"
alias ka="killall"
alias mkdir="mkdir -pv"
alias rf="source ~/.zshrc"

# listing
alias l='ls -alh --color=auto'
alias ll='ls -alh --format=horizontal --color=auto'
alias la='ls -alh --color=auto'
alias lt='ls -alrth --color=auto'
alias ls='ls -hN --group-directories-first --color=auto'

# git
alias g="git"
alias ga="git add ."
alias gc="git commit -m"
alias gd="git diff"
alias gg="git pull"
alias gl="git ls"
alias gp="git push origin master"
alias gpf="git push --force-with-lease"
alias gs="git st"

# npm
alias ns="npm start";
alias ni="npm install";
alias nt="npm test";
alias nrw="npm run workbench";

# tmux
alias tl="~/bin/tm"

# ranger
alias r="ranger"
alias sr="sudo ranger"

# docker
alias dki="docker run -i -t -P --network host"
alias dkd="docker run -d -P"
alias dpa="docker ps -a"
alias di="docker images"
alias drm='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'
alias drmi='docker rmi $(docker images -q -f dangling=true)'
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
dstop() { docker stop $(docker ps -a -q); }

# vagrant
alias vu='vagrant up'
alias vh='vagrant halt -f'
alias vd='vagrant destroy -f'
alias vs='vagrant ssh'
alias vp='vagrant provision'
