#!/usr/bin/env sh

mkdir -p out
cc main.c -lraylib -o out/reborn-of-dream -Werror -Wall -std=c99
