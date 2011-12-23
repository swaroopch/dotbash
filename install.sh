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

export BASH_BACKUP_DIR="/tmp/dotbash-backup"
mkdir -p $BASH_BACKUP_DIR
echo "Backing up existing bash and config files to $BASH_BACKUP_DIR"
for f in $(ls -a $BASH_BACKUP_DIR| grep -v '^.$' | grep -v '^..$')
do
    rm -rf "$BASH_BACKUP_DIR/$f"
done
for f in "$HOME/.bash_profile" "$HOME/.tmux.conf" "$HOME/.ackrc" "$HOME/.irbrc" "$HOME/.gitconfig" "$HOME/.gemrc"
do
    if [[ -f "$f" ]]
    then
        mv -f $f $bash_backup_dir
    fi
done

echo "Linking the template .bash_profile into ~/.bash_profile, edit this file to customize dotbash"
ln -s -f $BASH/template/my_bash_profile.bash $HOME/.bash_profile
if [[ "$OS" == "linux" ]]
then

    cat >> $HOME/.bashrc <<EOF

source \$HOME/.bash_profile

EOF

fi

echo "Setting up application-specific configs"
ln -s -f "$BASH/configs/tmux.conf" "$HOME/.tmux.conf"
ln -s -f "$BASH/configs/ackrc" "$HOME/.ackrc"
ln -s -f "$BASH/configs/irbrc" "$HOME/.irbrc"
ln -s -f "$BASH/configs/gitconfig" "$HOME/.gitconfig"
cp -f    "$BASH/configs/gemrc.yml" "$HOME/.gemrc"

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

source $HOME/.bash_profile

## Python
#if [[ $(type workon) =~ "not found" ]]
#then
    #curl -k -O http://python-distribute.org/distribute_setup.py
    #sudo python distribute_setup.py
    #rm distribute_setup.py
    #rm -f distribute*.tar.gz

    #curl -k -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    #sudo python get-pip.py
    #rm get-pip.py

    #sudo pip install -U virtualenv virtualenvwrapper
    #[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source "/usr/local/bin/virtualenvwrapper.sh"
#fi

echo "Finished. Open a new shell now!"
