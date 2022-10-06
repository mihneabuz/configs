#!/bin/bash

Targets="nvim ranger kitty fish xmonad starship.toml"

rm -rf .config

mkdir .config

for n in $Targets; do
	echo $n
	cp -r ~/.config/$n .config/
done
