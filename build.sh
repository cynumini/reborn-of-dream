#!/usr/bin/env sh

mkdir -p ./out
gcc ./src/main.c -o ./out/rod -l glfw
./out/rod $@
