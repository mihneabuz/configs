#!/bin/bash

targets="lf nvim kitty fish hypr waybar starship.toml wofi colors dunst"

rm -rf .config

mkdir .config

for n in $targets; do
  echo $n
  cp -r ~/.config/$n .config/
done

cp ~/.gitconfig .gitconfig
