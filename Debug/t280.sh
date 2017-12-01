#!/usr/bin/env bash

# clang -framework Foundation -dynamiclib LibT280.m -o LibT280.dylib
DYLD_INSERT_LIBRARIES=LibT280.dylib /Applications/Twitter.app/Contents/MacOS/Twitter 1>&- 2>&- &