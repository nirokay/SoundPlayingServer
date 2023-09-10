#!/usr/bin/env bash

# Configurable variables:
PLAYER="/usr/bin/cvlc"
FLAGS="--play-and-exit"

PATH="$1"
[ ! "$PATH" ] && echo "Specify a file!" && exit 1

echo "Playing '$PATH' with '$PLAYER' using flags '$FLAGS'!"
$PLAYER "$FLAGS" "$PATH"
