#!/usr/bin/env bash 

git status --porcelain | awk '$1 ~ /^D/ { print $2 }' | xargs git checkout

exit $?

