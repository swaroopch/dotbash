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

# Select correct user profile script
if [[ "$OS" == "mac" ]]
then
    PROFILE="$HOME/.profile"
else
    PROFILE="$HOME/.bashrc"
fi

cp $HOME/.bash_profile $HOME/.bash_profile.bak

echo "Your original .bash_profile has been backed up to .bash_profile.bak"

cp $BASH/template/my_bash_profile.bash $HOME/.bash_profile

echo "Copied the template .bash_profile into ~/.bash_profile, edit this file to customize dotbash"

echo "Setting up application-specific configs"
ln -s -i "$BASH/configs/tmux.conf" ~/.tmux.conf
ln -s -i "$BASH/configs/ackrc" ~/.ackrc
ln -s -i "$BASH/configs/irbrc" ~/.irbrc
ln -s -i "$BASH/configs/gitconfig" ~/.gitconfig
cp -i "$BASH/configs/gemrc.yml" ~/.gemrc

while true
do
  read -p "Do you use Jekyll? (If you don't know what Jekyll is, answer 'n') [Y/N] " RESP

  case $RESP
    in
    [yY])
      cp $BASH/template/jekyllconfig.template.bash $HOME/.jekyllconfig
      echo "Copied the template .jekyllconfig into your home directory. Edit this file to customize dotbash for using the Jekyll plugins"
      break
      ;;
    [nN])
      break
      ;;
    *)
      echo "Please enter Y or N"
  esac
done

function load_all() {
  file_type=$1
  [ ! -d "$BASH/$file_type/enabled" ] && mkdir "$BASH/${file_type}/enabled"
  ln -s $BASH/${file_type}/available/* "${BASH}/${file_type}/enabled"
}

function load_some() {
    file_type=$1
    for file in `ls $BASH/${file_type}/available`
    do
      if [ ! -d "$BASH/$file_type/enabled" ]
      then
        mkdir "$BASH/$file_type/enabled"
      fi
      while true
      do
        read -p "Would you like to enable the ${file%.*.*} $file_type? [Y/N] " RESP
        case $RESP in
        [yY])
          ln -s "$BASH/$file_type/available/$file" "$BASH/$file_type/enabled"
          break
          ;;
        [nN])
          break
          ;;
        *)
          echo "Please choose y or n."
          ;;
        esac
      done
    done
}

for type in "aliases" "plugins" "completion"
do
  while true
  do
    read -p "Would you like to enable all, some, or no $type? Some of these may make bash slower to start up (especially completion). (all/some/none) " RESP
    case $RESP
    in
    some)
      load_some $type
      break
      ;;
    all)
      load_all $type
      break
      ;;
    none)
      break
      ;;
    *)
      echo "Unknown choice. Please enter some, all, or none"
      continue
      ;;
    esac
  done
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

echo "Finished. Open a new shell now!"
