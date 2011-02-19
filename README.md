
# My Bash setup

# Installation

    if [[ "$OSTYPE" =~ "linux" ]] # Assumes Ubuntu
    then
        sudo apt-get install git curl
    elif [[ "$OSTYPE" =~ "darwin" ]]
    then
        brew install git curl
    else
        echo "Don't know how to install packages on $OSTYPE operating system"
        exit 1
    fi

    mkdir -p "$HOME/code/"
    cd "$HOME/code/"

    git clone git://github.com/swaroopch/dotbash.git
    cd dotbash
    bash install.bash

    echo "This fork includes customizations for my specific setup."
    echo "See https://github.com/revans/bash-it for the original documentation."
    echo "See http://commandlinefu.com for other cool commands you can add to your bash setup."

# Also See

- [Advanced Bash-Scripting Guide](http://tldp.org/LDP/abs/html/)
- [What `$*` and `$@` mean](http://tldp.org/LDP/abs/html/internalvariables.html#APPREF)
