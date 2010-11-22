
# dotbash

    if [[ "$OSTYPE" == "linux-gnu" ]]
    then
        sudo apt-get install git curl
    elif [[ "$OSTYPE" == "darwin10.0" ]]
    then
        brew install git curl
    fi

    mkdir -p "$HOME/code/"
    cd "$HOME/code/"

    git clone git://github.com/swaroopch/dotbash.git
    cd dotbash
    bash install.bash

    echo "This fork includes customizations for my specific setup."
    echo "See https://github.com/revans/bash-it for the original documentation."
