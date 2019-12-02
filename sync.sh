#!/bin/sh

# Update plugins
git submodule update --recursive --remote

# Symlink config files
ln -sv ~/dotfiles/.vim ~
ln -sv ~/dotfiles/zsh/.zshrc ~
