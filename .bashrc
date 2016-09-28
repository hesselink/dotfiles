# bash
export PATH=$HOME/.local/bin:$PATH
export HISTCONTROL=ignoredups,ignorespace
shopt -s histappend
#### Immediately append new commands to history instead of at terminal
#### close, and read all new history items.
export PROMPT_COMMAND="history -a; history -n"

# brew
for f in /usr/local/etc/bash_completion.d/*; do
  source $f;
done

# go
export GOPATH=$HOME/doc

# insta
PROG=insta source /usr/local/Homebrew/Library/Taps/palantir/homebrew-insta/autocomplete/bash_autocomplete

# git
alias g=git
complete -o default -o nospace -F _git g

# docker
for f in /Applications/Docker.app/Contents/Resources/etc/*.bash-completion; do
  source $f
done

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home
## gradle
source $HOME/.bash_completion/gradle-tab-completion.bash

# prompt
function ghc_version ()
{
  if which ghc > /dev/null; then
    echo \ \(`ghc --version | sed 's/.*version \(.*\)/\1/'`\);
  fi
}
export PS1="\[\033]0;\w\007
\033[32m\]\u@\h \[\033[33m\w\033[36m\]\$(__git_ps1 \" %s\")\033[34m\]\$(ghc_version)\033[0m\]
$ "

# haskell
eval "$(stack --bash-completion-script "$(which stack)")"

# node
export NODE_REPL_HISTORY_FILE=$HOME/.node_history

# general
function up()
{
    dir=""
    if [ -z "$1" ]; then
        dir=..
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        x=0
        while [ $x -lt ${1:-1} ]; do
            dir=${dir}../
            x=$(($x+1))
        done
    else
        dir=${PWD%/$1/*}/$1
    fi
    cd "$dir";
}
export EDITOR="vim"
alias less='less -R'
alias ls='ls -G'
