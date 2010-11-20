#!/usr/bin/env bash

# Assumption of directory location
DOTBASH="$HOME/code/dotbash"

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
elif [[ "$OSTYPE" = "linux-gnu" ]] # Ubuntu
then
    PROFILE="$HOME/.bashrc"
else
    echo "Don't know what to do on '$OSTYPE' operating system"
    exit 1
fi

echo "Setting up bash profile."
echo >> $PROFILE # Adding a new line for separation, in case last line does not end with a newline.
echo "[ -s \"$DOTBASH/template/my_bash_profile.bash\" ] && source \"$DOTBASH/template/my_bash_profile.bash\"" >> $PROFILE

echo "Setting up application-specific configs"
ln -s "$DOTBASH/configs/tmux.conf" ~/.tmux.conf
ln -s "$DOTBASH/configs/ackrc" ~/.ackrc
ln -s "$DOTBASH/configs/irbrc" ~/.irbrc
ln -s "$DOTBASH/configs/gitconfig" ~/.gitconfig

echo "Finished. Open a new shell now!"
