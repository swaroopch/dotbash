#!/usr/bin/env bash

function remove_old_files
{
    number_of_days="$1" # e.g. "2"
    glob_pattern="$2" # e.g. "*.zip"
    if [[ "$number_of_days" = "" || "$glob_pattern" = "" ]]
    then
        echo "Usage: remove_old_files number_of_days glob_pattern"
        return 1
    fi

    find . -iname "$glob_pattern" -mtime +$number_of_days -exec rm -v '{}' \;
}
