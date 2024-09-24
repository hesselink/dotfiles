# bash
export PATH=$HOME/.local/bin:$PATH
export HISTCONTROL=ignoredups,ignorespace
shopt -s histappend
#### Immediately append new commands to history instead of at terminal
#### close, and read all new history items.
export PROMPT_COMMAND="history -a; history -n"
export BASH_SILENCE_DEPRECATION_WARNING=1

# brew

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [ -d "{HOMEBREW_PREFIX}/bin" ]; then
    PATH="{HOMEBREW_PREFIX}/bin":$PATH
  fi
  if [ -d "{HOMEBREW_PREFIX}/sbin" ]; then
    PATH="{HOMEBREW_PREFIX}/sbin":$PATH
  fi

  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# completion

if [ -f /etc/profile.d/bash_completion.sh ]; then # centos
  source /etc/profile.d/bash_completion.sh
fi

if [ -d $HOME/.bash_completion.d ]; then # custom
  for f in $HOME/.bash_completion.d/*; do
    source $f;
  done
fi

# go
export GOPATH=$HOME/doc

# insta
[[ -s /usr/local/Homebrew/Library/Taps/palantir/homebrew-insta/autocomplete/bash_autocomplete ]] &&
  PROG=insta source /usr/local/Homebrew/Library/Taps/palantir/homebrew-insta/autocomplete/bash_autocomplete

# kubectl-scripts
if [[ -f $HOME/code/kubectl-scripts/bash.sh ]]; then
    source $HOME/code/kubectl-scripts/bash.sh
fi


# git
alias g=git
_completion_loader git
__git_complete g __git_main

# docker
if [ -d /Applications/Docker.app/Contents/Resources/etc/ ]; then
  for f in /Applications/Docker.app/Contents/Resources/etc/*.bash-completion; do
    source $f
  done
fi

# java
[[ -f /usr/libexec/java_home ]] && export JAVA_HOME=$(/usr/libexec/java_home -v 11)
[[ -f /usr/libexec/java_home ]] && export JAVA_1_8_HOME=$(/usr/libexec/java_home -v 1.8 -F 2> /dev/null)
[[ -f /usr/libexec/java_home ]] && export JAVA_1_6_HOME=$(/usr/libexec/java_home -v 1.6 -F 2> /dev/null)

## gradle
[[ -s $HOME/.bash_completion/gradle-tab-completion.bash ]] &&
  source $HOME/.bash_completion/gradle-tab-completion.bash
alias gw=./gradlew

# prompt
function ghc_version ()
{
  if which ghc > /dev/null 2>&1; then
    echo \ \(`ghc --version | sed 's/.*version \(.*\)/\1/'`\);
  fi
}
export PS1="\[\033]0;\w\007
\033[32m\]\u@\h \[\033[33m\w\033[36m\]\$(__git_ps1 \" %s\")\033[34m\]\$(ghc_version)\033[0m\]
$ "

# haskell
if `which stack >> /dev/null 2>&1`; then
  eval "$(stack --bash-completion-script "$(which stack)")"
fi

# node
export NODE_REPL_HISTORY_FILE=$HOME/.node_history

# python
if [ -d $HOME/Library/Python/2.7/bin ]; then
  export PATH=$HOME/Library/Python/2.7/bin/:$PATH
fi

if [ -d $HOME/Library/Python/3.7/bin ]; then
  export PATH=$HOME/Library/Python/3.7/bin/:$PATH
fi

# rust
if [ -d $HOME/.cargo/bin ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

#pgdev
export REBUILD_HYDRATION=true

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
