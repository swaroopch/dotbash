#!/bin/bash

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
    v
}
