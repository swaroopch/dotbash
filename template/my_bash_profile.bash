#!/bin/bash

## Shell and OS check

if [ "$BASH_VERSION" = "" ]
then
    echo "I work only with Bash"
    exit 1
fi

if [[ "$OSTYPE" =~ "darwin" ]]
then
    export OS="mac"
    export GVIM="open -a MacVim"
elif [[ "$OSTYPE" == "linux-gnu" ]]
then
    export OS="linux"
    export GVIM="gvim"
else
    echo "Don't know what to do with '$OSTYPE' operating system"
    exit 1
fi

## Vim

# Set my editor and git editor
if [[ "$OS" == "mac" ]]
then
    # brew uninstall macvim
    # brew install --head macvim
    # mkdir -p $HOME/Applications
    # brew linkapps
    ## 1. Using MacVim makes copy/paste work from within Terminal
    ## 2. Using compiled MacVim enables ruby, python Vim-scripting
    export EDITOR='$HOME/Applications/MacVim.app/Contents/MacOS/Vim'
    alias vim=$EDITOR
else
    export EDITOR='vim'
fi

## Python
export VIRTUALENV_USE_DISTRIBUTE=1
## http://jacobian.org/writing/when-pypi-goes-down/
export PIP_USE_MIRRORS=1
## This is needed when I have already set a 'venv' and I start tmux -
## The prompt shows the venv name but the PATHs are not actually set
## and the default 'python' is the system-wide default python.
if [[ "$VIRTUAL_ENV" != "" ]]
then
    source "$VIRTUAL_ENV/bin/activate"
fi

## Ruby
### Use RBENV if present
if [[ -s $HOME/.rbenv ]]
then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
else
    if [[ -d "/var/lib/gems/1.8/bin" ]]
    then
        export PATH="/var/lib/gems/1.8/bin:$PATH"
    fi
fi
### Else use RVM
#[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

## Bash

# Path to the bash it configuration
export BASH=$HOME/code/dotbash

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_THEME='my'

# Load Bash It
if [[ "$TERM" != "dumb" ]] # To prevent tput errors when someone scps to this box
then
    source $BASH/bash_it.sh
fi

# Homebrew
if [[ "$OS" == "mac" ]]
then
    # brew doctor
    # http://mxcl.github.com/homebrew/
    export PATH="${PATH/\/usr\/local\/bin:/}"  # Remove directory from PATH
    export PATH="${PATH/\/usr\/local\/sbin:/}" # Remove directory from PATH
    # Add to the head of the PATH
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

    # Ruby bin (because `brew install ruby` installs latest 1.9.3-p0 (as of this writing) and Mac OS X Lion has Ruby 1.8.7)
    if [[ "$(brew list | grep '^ruby$')" != "" ]]
    then
        export PATH="$(brew --prefix ruby)/bin:$PATH"
    fi
fi

## System

[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"

## Cleanup

# Don't check mail when opening terminal.
unset MAILCHECK

#unset OS
