#!/usr/bin/env bash

function sync_folders
{
    from="$1"
    to="$2"
    if [[ "$from" = "" || "$to" = "" ]]
    then
        echo "Usage: sync from_dir to_dir"
        return 1
    fi

    from=${from%/} # strip ending slash
    to=${to%/} # strip ending slash

    rsync -rlmh --delete-before --copy-unsafe-links --progress --stats $from $to
}
