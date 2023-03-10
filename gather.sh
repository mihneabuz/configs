#!/bin/bash

Targets="lf nvim kitty fish hypr nemo waybar starship.toml wofi yabai skhd"

rm -rf .config

mkdir .config

for n in $Targets; do
	echo $n
	cp -r ~/.config/$n .config/
done

cp ~/.gitconfig .gitconfig
