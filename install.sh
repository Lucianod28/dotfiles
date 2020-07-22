#!/bin/sh

# Update plugins
git submodule update --init --recursive

# Symlink config files
ln -sv ~/dotfiles/.vim ~
ln -sv ~/dotfiles/zsh/.zshrc ~

mkdir ~/.vim/undo
mkdir ~/.vim/swap
