#emacs keybindings
set -o emacs

#Path stuff
#Add brew install path to PATH
export PATH="/usr/local/bin:$PATH"
export PATH=~/.local/bin:$PATH

#Go path stuff
#export GOPATH=$HOME/go
#export PATH=$PATH:$GOPATH/bin

#Hub alias
alias git=hub

#Add bash completion
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
# fi

#Add grunt completion
#eval "$(grunt --completion=bash)"

#Add current git branch to prompt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

#Set default editor to be emacs
export EDITOR="emacs -nw"

#Postgres data
export PGDATA="/usr/local/var/postgres/"

#Git alias
alias gs="git status"
alias gpull="git pull"
alias gpush="git push"
alias gc="git checkout"
alias gcm="git commit -m"

#Homebrew alias
alias brewup="brew update && brew upgrade --all"

## Colorize the ls output ##
alias ls='ls -G'

## Use a long listing format ##
alias ll='ls -la -G'

## Show hidden files ##
alias l.='ls -d .*'
