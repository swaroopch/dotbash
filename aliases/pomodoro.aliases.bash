#!/bin/bash

POMO_DIR="$HOME/Desktop/Pomodoros"
mkdir -p $POMO_DIR

# Currently, this does nothing special, it just creates a file for today
function pomodoro_today()
{
    today_file="$POMO_DIR/$(date +%Y%m%d).txt"

    if [[ ! -f $today_file ]]
    then
        cat > $today_file <<EOF
$(date +"h1. %A, %B %d, %Y")

Task 1
[] []

Task 2
[] []
EOF
    fi

    $GVIM $today_file
}
