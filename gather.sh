#!/bin/bash

targets="lf nvim kitty fish hypr nemo waybar starship.toml wofi colors helix dunst"

rm -rf .config

mkdir .config

for n in $targets; do
  echo $n
  cp -r ~/.config/$n .config/
done

cp ~/.gitconfig .gitconfig
