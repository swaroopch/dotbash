
# Set GOROOT
if [[ "$OS" == "mac" ]]
then
    GR=$(brew info go | tail -2 | head -1 | awk '{print $1}')

    if [[ -d "$GR" ]]
    then
        export GOROOT=$GR
    fi
fi

# Shortcut to compile Golang programs
# http://golang.org/doc/go_tutorial.html#tmp_41
function 6run
{
    filename=$1
    shift

    if [[ "$filename" == "" ]]
    then
        echo "Usage: 6run foo.go"
        return 1
    fi

    name=${filename%.go}

    for dep in $@
    do
        6g $dep || return $?
    done

    6g "${name}.go" || return $?

    6l -o "${name}" "${name}.6" || return $?

    ./${name}
}
