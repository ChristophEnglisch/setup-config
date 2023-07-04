export PATH=/opt/homebrew/bin:$PATH
export DEFAULT_USER="cenglisch"
export ZSH="/Users/cenglisch/.oh-my-zsh"

ZSH_THEME="agnoster"

export PATH="/usr/local/opt/mysql-client/bin:$PATH"

plugins=(git macos docker docker-compose mysql)

source $ZSH/oh-my-zsh.sh

alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ga="git add"
alias gcm="git commit -m"
alias gph="git push"
alias ll="ls -la -G"
alias g="git"
alias gp="git pull"
alias gcl='git checkout -'
alias zshconfig="idea ~/.zshrc"
alias install="brew install"
alias uninstall="brew uninstall"

function gamp() {
    if [[ -z $(git status -s) ]]; then
        echo "Es liegen keine ungespeicherten Änderungen im Arbeitsverzeichnis vor."
        return 1
    fi

    local branch_name=$(git rev-parse --abbrev-ref HEAD)

    git add .
    git commit -m "$branch_name"
    git push
}


function md() {
	mkdir -p "$@" && cd "$@"
}

function docker_reset(){
   docker system prune --all;
   docker volume rm $(docker volume ls -q);
}