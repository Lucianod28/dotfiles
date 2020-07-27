#!/bin/sh

# Update plugins
git submodule update --init --recursive

# Symlink config files
ln -sv $HOME/dotfiles/.vim $HOME
ln -sv $HOME/dotfiles/.zsh/zshrc $HOME/.zshrc

mkdir $HOME/.vim/undo
mkdir $HOME/.vim/swap
