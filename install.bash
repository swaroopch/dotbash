#!/usr/bin/env bash

## Check Bash Version

if [ "$BASH_VERSION" = "" ]
then
    echo "I work only with Bash"
    exit 1
fi

## Check Git is installed
if [[ $(which git) == "" ]]
then
    echo "Please ensure that git is installed"
    exit 1
fi

## Check OS

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

# Select correct user profile script
if [[ "$OS" == "mac" ]]
then
    PROFILE="$HOME/.profile"
else
    PROFILE="$HOME/.bashrc"
fi

# Assumption of directory location
DOTBASH="$HOME/code/dotbash"
cd $DOTBASH

echo "Setting up bash profile."
echo >> $PROFILE # Adding a new line for separation, in case last line does not end with a newline.
echo "[ -s \"$DOTBASH/template/my_bash_profile.bash\" ] && source \"$DOTBASH/template/my_bash_profile.bash\"" >> $PROFILE

echo "Setting up application-specific configs"
ln -s -i "$DOTBASH/configs/tmux.conf" ~/.tmux.conf
ln -s -i "$DOTBASH/configs/ackrc" ~/.ackrc
ln -s -i "$DOTBASH/configs/irbrc" ~/.irbrc
ln -s -i "$DOTBASH/configs/gitconfig" ~/.gitconfig

## XXX YOU MUST CHANGE THIS FOR YOUR OWN CUSTOM SETUP
if [[ "$CUSTOM" == "yes" ]]
then
    DOTBASH_CUSTOM="$HOME/code/dotbash_custom"

    if [[ ! -d "$DOTBASH_CUSTOM" ]]
    then
        mkdir -p "$DOTBASH_CUSTOM/.."
        cd "$DOTBASH_CUSTOM/.."
        # XXX THIS IS MY PRIVATE REPO. YOU CANNOT ACCESS THIS.
        git clone git@github.com:swaroopch/dotbash_custom.git
    else
        cd $DOTBASH
        git pull
    fi

    echo "Setting up custom configs"
    ln -s -i "$DOTBASH_CUSTOM/servers.bash" "$DOTBASH/custom/servers.bash"
fi

echo "Finished. Open a new shell now!"
