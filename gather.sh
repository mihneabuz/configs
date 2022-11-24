#!/bin/bash

Targets="lf nvim kitty fish hypr nemo starship.toml"

rm -rf .config

mkdir .config

for n in $Targets; do
	echo $n
	cp -r ~/.config/$n .config/
done
