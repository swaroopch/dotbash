#!/bin/bash

if [[ -d "$HOME/.rbenv" ]]
then
    # Load rbenv, if you are using it
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    # Load the auto-completion script if rbenv was loaded.
    source "$HOME/.rbenv/completions/rbenv.bash"
fi
