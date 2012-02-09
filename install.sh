#!/usr/bin/env bash
BASH_IT="$HOME/code/dotbash"
cd $BASH_IT

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

if [[ "$OSTYPE" =~ "darwin" ]]
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
        cp -vf $f $BASH_BACKUP_DIR
    fi
done

echo "Linking the template .bash_profile into ~/.bash_profile, edit this file to customize dotbash"
ln -s -f $BASH_IT/template/my_bash_profile.bash $HOME/.bash_profile
if [[ "$OS" == "linux" ]]
then

    cat >> $HOME/.bashrc <<EOF

source \$HOME/.bash_profile

EOF

fi

echo "Setting up application-specific configs"
ln -s -i "$BASH_IT/configs/tmux.conf" "$HOME/.tmux.conf"
ln -s -i "$BASH_IT/configs/ackrc" "$HOME/.ackrc"
ln -s -i "$BASH_IT/configs/irbrc" "$HOME/.irbrc"
cp    -i "$BASH_IT/configs/gitconfig" "$HOME/.gitconfig"
cp    -i "$BASH_IT/configs/gemrc.yml" "$HOME/.gemrc"

function load_all() {
  file_type=$1
  [ ! -d "$BASH_IT/$file_type/enabled" ] && mkdir "$BASH_IT/${file_type}/enabled"
  ln -s $BASH_IT/${file_type}/available/* "${BASH_IT}/${file_type}/enabled"
}

for type in "aliases" "plugins" "completion"
do
    load_all $type
done

## WORKAROUND This was doing some funky stuff with the command prompt when using iTerm2 on Mac OS X Lion
rm -f "${BASH_IT}/plugins/enabled/xterm.plugins.bash"

source $HOME/.bash_profile

echo "Finished. Open a new shell now!"
