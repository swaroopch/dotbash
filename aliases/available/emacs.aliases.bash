#!/bin/bash

case $OSTYPE in
  linux*)
    alias em='emacs'
    # alias e='emacsclient -n'
    alias e='emacs -nw'
    ;;
  darwin*)
    alias em="open -a emacs"
    # http://emacsformacosx.com/
    alias e="open -a /Applications/Emacs.app/Contents/MacOS/Emacs"
    ;;
esac
