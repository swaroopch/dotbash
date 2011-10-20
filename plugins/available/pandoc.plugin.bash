
function convert_textile_to_html()
{
    inputfile=$1
    shift

    outputfile="${inputfile%.txt}.html"

    pandoc -f textile -t html $inputfile -o $outputfile

    if [[ "$OS" == "mac" ]]
    then
        open $outputfile
    elif [[ "$OS" == "linux" ]]
    then
        gnome-open $outputfile
    fi
}
