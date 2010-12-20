#!/bin/bash

if [[ -f "$HOME/.ssh/config" ]]
then
    complete -W "$(echo `cat $HOME/.ssh/config | grep -iE '^Host' | awk '{ print $2 }'`)" ssh
fi
