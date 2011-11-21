
# https://github.com/mxcl/homebrew/blob/master/Library/Formula/node.rb#L39
if [ "$OS" == "mac" ]
then
    export NODE_PATH="$(brew --prefix)/lib/node_modules"
fi
