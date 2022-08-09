#!/bin/bash

Targets="nvim ranger kitty fish starship.toml"

rm -rf .config

mkdir .config

for n in $Targets; do
	echo $n
	cp -r ~/.config/$n .config/
done
