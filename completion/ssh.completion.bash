#!/bin/bash

complete -W "$(echo `cat ~/.ssh/config | grep -iE '^(Host|HostName)' | awk '{ print $2 }'`)" ssh
