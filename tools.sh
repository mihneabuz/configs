#!/bin/bash

set -e

pacman -S \
  base-devel \
  curl \
  wget \
  zip \
  unzip \
  git \
  python \
  python-pip \
  nodejs \
  npm \
  go \
  rustup \
  neovim \
  fish \
  starship \
  lf \
  tree \
  highlight \
  fd \
  fzf \
  ripgrep \
  htop \
  lazygit \
  tree-sitter-cli

rustup default stable
