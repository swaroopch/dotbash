#!/usr/bin/env bash
BASH="$HOME/code/dotbash"
cd $BASH

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

cp $HOME/.bash_profile $HOME/.bash_profile.bak

echo "Your original .bash_profile has been backed up to .bash_profile.bak"

ln -s -i $BASH/template/my_bash_profile.bash $HOME/.bash_profile

echo "Copied the template .bash_profile into ~/.bash_profile, edit this file to customize dotbash"

echo "Setting up application-specific configs"
ln -s -i "$BASH/configs/tmux.conf" ~/.tmux.conf
ln -s -i "$BASH/configs/ackrc" ~/.ackrc
ln -s -i "$BASH/configs/irbrc" ~/.irbrc
ln -s -i "$BASH/configs/gitconfig" ~/.gitconfig
cp -i "$BASH/configs/gemrc.yml" ~/.gemrc

function load_all() {
  file_type=$1
  [ ! -d "$BASH/$file_type/enabled" ] && mkdir "$BASH/${file_type}/enabled"
  ln -s $BASH/${file_type}/available/* "${BASH}/${file_type}/enabled"
}

for type in "aliases" "plugins" "completion"
do
    load_all $type
done

## XXX YOU MUST CHANGE THIS FOR YOUR OWN CUSTOM SETUP
if [[ "$CUSTOM" == "yes" ]]
then
    BASH_CUSTOM="$HOME/code/dotbash_custom"

    if [[ ! -d "$BASH_CUSTOM" ]]
    then
        mkdir -p "$BASH_CUSTOM/.."
        cd "$BASH_CUSTOM/.."
        # XXX THIS IS MY PRIVATE REPO. YOU CANNOT ACCESS THIS.
        git clone git@github.com:swaroopch/dotbash_custom.git
    else
        cd $BASH
        git pull
    fi

    echo "Setting up custom configs"
    bash "$BASH_CUSTOM/install.sh"
fi

## Python
source $HOME/.bash_profile
if [[ "$WORKON_HOME" != "" ]]
then
    if [[ $(type mkvirtualenv | head -1) =~ "is a function" ]] && [[ $(type workon | head -1) =~ "is a function" ]]
    then
        if [[ ! -d "$WORKON_HOME/default" ]]
        then
            mkvirtualenv default
        fi

        workon default

        if [[ $(which pyflakes) == "" ]]
        then
            pip install pyflakes
        fi
    else
        echo "Optional: virtualenvwrapper is not installed, so please install that, then create 'default' virtualenv and install pyflakes"
    fi
fi

echo "Finished. Open a new shell now!"
