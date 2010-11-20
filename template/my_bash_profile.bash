#!/bin/bash

## Shell and OS check

if [ "$BASH_VERSION" = "" ]
then
    echo "I work only with Bash"
    exit 1
fi

if [[ "$OSTYPE" == "darwin10.0" ]]
then
    export OS="mac"
elif [[ "$OSTYPE" == "linux-gnu" ]]
then
    export OS="linux"
else
    echo "Don't know what to do with '$OSTYPE' operating system"
    exit 1
fi

## Vim

# Set my editor and git editor
if [[ "$OS" == "mac" ]]
then
    # brew install --head macvim
    # cp -r /usr/local/Cellar/macvim/HEAD/MacVim.app /Applications/
    ## 1. Using MacVim makes copy/paste work from within Terminal
    ## 2. Using compiled MacVim enables ruby, python Vim-scripting
    export EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim'
else
    export EDITOR='vim'
fi

## Python

# VirtualEnv
export VIRTUALENV_USE_DISTRIBUTE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
# sudo apt-get install python-distribute
# sudo easy_install virtualenv==tip
# cd $HOME/local && virtualenv pyenv
[[ -s "$HOME/local/pyenv/bin/activate" ]] && source "$HOME/local/pyenv/bin/activate"

## Ruby

# Load RVM, if you are using it
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Add rvm gems to the path
export PATH=$HOME/.gem/ruby/1.8/bin:$PATH

## Bash

# Path to the bash it configuration
export BASH=$HOME/code/dotbash

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_THEME='bobby'

## Git

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@github.com:swaroopch'

## System

if [[ "$OS" == "mac" ]]
then
    # brew doctor
    # http://mxcl.github.com/homebrew/
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Don't check mail when opening terminal.
unset MAILCHECK

## Get Everything

# Load Bash It
source $BASH/bash_it.sh

## Cleanup

unset OS
