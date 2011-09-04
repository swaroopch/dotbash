
# Shortcut to compile Golang programs
# http://golang.org/doc/go_tutorial.html#tmp_41
function 6run
{
    filename=$1
    shift

    name=${filename%.go}

    6g "${name}.go"
    6l -o "${name}" "${name}.6"
    ./${name}
}
