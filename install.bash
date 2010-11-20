#!/usr/bin/env bash

if [ "$BASH_VERSION" = "" ]
then
    echo "I work only with Bash"
    exit 1
fi

# Select correct user profile script
if [[ "$OSTYPE" == "darwin10.0" ]] # Mac OS X
then
    PROFILE="$HOME/.profile"
elif [[ "$OSTYPE" == "linux-gnu" ]] # Ubuntu
then
    PROFILE="$HOME/.bashrc"
else
    echo "Don't know what to do on '$OSTYPE' operating system"
    exit 1
fi

# Assumption of directory location
DOTBASH="$HOME/code/dotbash"

if [[ ! -d "$DOTBASH" ]]
then
    mkdir -p "$DOTBASH/.."
    cd "$DOTBASH/.."
    git clone git@github.com:swaroopch/dotbash.git
else
    cd $DOTBASH
    git pull
fi

echo "Setting up bash profile."
echo >> $PROFILE # Adding a new line for separation, in case last line does not end with a newline.
echo "[ -s \"$DOTBASH/template/my_bash_profile.bash\" ] && source \"$DOTBASH/template/my_bash_profile.bash\"" >> $PROFILE

echo "Setting up application-specific configs"
ln -s -f "$DOTBASH/configs/tmux.conf" ~/.tmux.conf
ln -s -f "$DOTBASH/configs/ackrc" ~/.ackrc
ln -s -f "$DOTBASH/configs/irbrc" ~/.irbrc
ln -s -f "$DOTBASH/configs/gitconfig" ~/.gitconfig

## Custom -- YOU MUST CHANGE THIS FOR YOUR OWN CUSTOM SETUP
if [[ "$CUSTOM" == "yes" ]]
then
    DOTBASH_CUSTOM="$HOME/code/dotbash_custom"

    if [[ ! -d "$DOTBASH_CUSTOM" ]]
    then
        mkdir -p "$DOTBASH_CUSTOM/.."
        cd "$DOTBASH_CUSTOM/.."
        git clone git@github.com:swaroopch/dotbash_custom.git
    else
        cd $DOTBASH
        git pull
    fi

    echo "Setting up custom configs"
    ln -s -f "$DOTBASH_CUSTOM/servers.bash" "$DOTBASH/custom/servers.bash"
fi

echo "Finished. Open a new shell now!"
