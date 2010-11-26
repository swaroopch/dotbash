#!/bin/bash

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
    vim -c ":NERDTree $module_directory"
    # OR:
    #   vim -c "$module_directory"
    # for those who don't use NERDTree plugin
}
