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

## Helpers

function prepend_path() {
    dir=$1
    shift

    escaped_dir=${dir//\//\\\/}

    # Two slashes means global replacement
    export PATH="$dir:${PATH//$escaped_dir:/}"
}

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
    # $(brew doctor)
    prepend_path "/usr/local/sbin"
    prepend_path "/usr/local/bin"

    # Ruby bin (because `brew install ruby` installs latest 1.9.3-p0 (as of this writing) and Mac OS X Lion has Ruby 1.8.7)
    #if [[ "$(brew list | grep '^ruby$')" != "" ]]
    #then
        #prepend_path "$(brew --prefix ruby)/bin"
    #fi
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
    prepend_path "$VIRTUAL_ENV/bin"
fi

## Ruby
### Use RBENV if present
if [[ -s "$HOME/.rbenv" ]]
then
    prepend_path "$HOME/.rbenv/bin"
    eval "$(rbenv init -)"
else
    if [[ -d "/var/lib/gems/1.8/bin" ]]
    then
        prepend_path "/var/lib/gems/1.8/bin"
    fi
fi
## Else use RVM
#[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

## System

[[ -d "$HOME/bin" ]] && prepend_path "$HOME/bin"

## Cleanup

# Don't check mail when opening terminal.
unset MAILCHECK

#unset OS
