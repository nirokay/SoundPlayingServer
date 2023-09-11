#!/usr/bin/bash

# Configurable variables:
PLAYER="/usr/bin/cvlc"
FLAGS="--play-and-exit"

PATH="$1"
[ ! "$PATH" ] && echo "Specify a file!" && exit 1
[ ! -f "$PATH" ] && echo "No such file found file!" && exit 1

DATE=$(/usr/bin/date "+%y-%m-%d   %H:%M:%S")

echo "$DATE | Playing '$PATH' with '$PLAYER' using flags '$FLAGS'!"
($PLAYER "$FLAGS" "$PATH" &) &> /dev/null
