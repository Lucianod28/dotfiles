#!/bin/sh

# Update plugins
git submodule update --recursive --remote

# Symlink config files
ln -sv ~/dotfiles/.vim ~
ln -sv ~/dotfiles/zsh/.zshrc ~

# Install vim-plug plugin manager
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim +PlugInstall +qall

mkdir ~/.vim/undodir
