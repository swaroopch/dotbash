
# Set GOROOT
if [[ "$OS" == "mac" ]]
then
    export GOROOT=$(brew info go | tail -2 | head -1 | awk '{print $1}')

    if [[ ! -d "$GOROOT" ]]
    then
        unset GOROOT
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

    6g "${name}.go"
    6l -o "${name}" "${name}.6"
    ./${name}
}
