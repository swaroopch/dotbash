#!/bin/bash

if [[ -f "$HOME/.ssh/config" ]]
then
    complete -W "$(echo `cat $HOME/.ssh/config | grep -iE '^(Host|HostName)' | awk '{ print $2 }'`)" ssh
fi
