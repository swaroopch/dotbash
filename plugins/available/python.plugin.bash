cite about-plugin
about-plugin 'alias "http" to SimpleHTTPServer'

if [ $(uname) = "Linux" ]
then
  alias http='python2 -m SimpleHTTPServer'
else
  alias http='python -m SimpleHTTPServer'
fi

function egg_edit
{
    module="$1"
    if [[ "$module" == "" ]]
    then
        echo "Usage: egg_edit <module name>"
        return 1
    fi

    module_file=$(python -c "import $module; print $module.__file__")
    if [[ "$module_file" == "" ]]
    then
        return 1
    fi

    module_directory=$(dirname $module_file)
    cd $module_directory
    v -c NERDTree
}

export VIRTUALENV_HOME=$HOME/.virtualenvs
mkdir -p $VIRTUALENV_HOME

function venvmake {
    local name=$1
    shift

    if [[ "" == "$name" ]]
    then
        echo "Usage: venvmake <name>"
        return 1
    fi

    if [[ -d "$VIRTUALENV_HOME/$name" ]]
    then
        echo "$name virtualenv already exists"
        return 1
    fi

    virtualenv --no-site-packages $VIRTUALENV_HOME/$name
}

function venv {
    local name=$1
    shift

    if [[ "" == "$name" ]]
    then
        echo "Usage: venv <name>"
        if [[ "" != "$(ls -1 $VIRTUALENV_HOME)" ]]
        then
            echo "Available environments:"
            ls -1 $VIRTUALENV_HOME
        else
            echo "Use venvmake to create an environment first"
        fi
        return 1
    fi

    if [[ ! -d "$VIRTUALENV_HOME/$name" ]]
    then
        echo "$name environment does not exist. Run 'venvmake $name' first."
        return 1
    fi

    source $VIRTUALENV_HOME/$name/bin/activate
}
