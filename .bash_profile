#emacs keybindings
set -o emacs

#Path stuff
#Add brew install path to PATH
export PATH=/usr/local/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.cargo/bin:$PATH

#Hub alias
alias git=hub

#Add bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

#Add current git branch to prompt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\u:\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

#Set default editor to be neovim
export EDITOR="/usr/local/bin/nvim"

#Postgres data
export PGDATA="/usr/local/var/postgres/"

#Homebrew alias
alias brewup="brew update && brew upgrade --all"

## Colorize the ls output ##
alias ls='ls -G'

## Use a long listing format ##
alias ll='ls -la -G'

## Show hidden files ##
alias l.='ls -d .*'

export NVM_DIR="/Users/ryanr/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
