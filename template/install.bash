#!/usr/bin/env bash

# Assumption of directory location
DOTBASH="$HOME/Code/Repos/dotbash"

if [[ ! -d "$DOTBASH" ]]
then
    mkdir -p "$DOTBASH/.."
    cd "$DOTBASH/.."
    git clone git@github.com:swaroopch/dotbash.git
fi

# Source it in the correct user profile script
if [[ "$OSTYPE" = "darwin10.0" ]] # Mac OS X
then
    PROFILE="$HOME/.profile"
elif [[ "$OSTYPE" == "linux-gnu" ]] # Ubuntu
then
    PROFILE="$HOME/.bashrc"
fi

echo >> $PROFILE # Adding a new line for separation, in case last line does not end with a newline.
echo "[ -s \"$DOTBASH/template/my_bash_profile.bash\" ] && source \"$DOTBASH/template/my_bash_profile.bash\"" >> $PROFILE

echo "Finished setting up bash profile. Open a new shell now!"
