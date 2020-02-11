#!/bin/sh

# Update plugins
git submodule update --recursive --remote

# Symlink config files
ln -sv ~/dotfiles/.vim ~
ln -sv ~/dotfiles/zsh/.zshrc ~

# Install vim-plug plugin manager
if [ ! -f ~/dotfiles/.vim/autoload/plug.vim ]; then
    curl -fLo ~/dotfiles/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
