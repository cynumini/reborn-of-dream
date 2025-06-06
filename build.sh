#!/usr/bin/env sh

set -e

name=$(basename $(pwd))
bin="./out/$name"

mkdir -p out
cc main.c -lraylib -o $bin -Werror -Wall -std=gnu99 -g -Og

if [[ $1 == "run" ]]; then
    $bin
elif [[ $1 == "gdb" ]]; then
    gdb $bin
fi
