#!/bin/bash

# Important if you have installed XCode 4 on Mac OS X
# http://stackoverflow.com/questions/5944332/#5944375
if [[ "$OS" == "mac" ]]
then
    export ARCHFLAGS='-arch i386 -arch x86_64'
fi
