#!/bin/bash

## Settings
MY_USER_NAME='swaroop'

## Shell and OS check

if [ "$BASH_VERSION" = "" ]
then
    echo "I work only with Bash"
    exit 1
fi

if [[ "$OSTYPE" == "darwin10.0" || "$OSTYPE" == "darwin11" ]]
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
    # rm -rf /Applications/MacVim.app
    # cp -r /usr/local/Cellar/macvim/*/MacVim.app /Applications
    ## 1. Using MacVim makes copy/paste work from within Terminal
    ## 2. Using compiled MacVim enables ruby, python Vim-scripting
    export EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim'
    alias vim=$EDITOR
else
    export EDITOR='vim'
fi

## Python
#if [[ "$USER" == "$MY_USER_NAME" ]] # NOTE https://bitbucket.org/dhellmann/virtualenvwrapper/issue/62/hooklog-permissions#comment-231449
#then
    #export VIRTUALENV_USE_DISTRIBUTE=1
    #export WORKON_HOME="$HOME/local/virtualenvs"
    #export PIP_VIRTUALENV_BASE=$WORKON_HOME
    #mkdir -p $WORKON_HOME
    #[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source "/usr/local/bin/virtualenvwrapper.sh"
    #if [[ $(type workon 2>&1 | head -1) =~ "is a function" ]]
    #then
        #if [[ ! -d "$WORKON_HOME/default" ]]
        #then
            #mkvirtualenv default
        #fi
        #workon default
    #fi
#fi

## Ruby
### Use RBENV if present
[[ -s $HOME/.rbenv ]] && export PATH=$HOME/.rbenv/bin:$PATH && eval "$(rbenv init -)"
### Use RVM if present, only if RBENV not present
#[[ "$RBENV_PRESENT" == "" ]] && [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

## Bash

# Path to the bash it configuration
export BASH=$HOME/code/dotbash

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_THEME='my'

## System

[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"

# Don't check mail when opening terminal.
unset MAILCHECK

## Get Everything

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
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

## Cleanup

#unset OS
