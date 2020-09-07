# dotfiles
This repo contains the configuration files (dotfiles) and plugins (as git submodules) I use for vim
and zsh.

## Installation
Before installation, remove existing `~/.vim/` and `~/.zshrc` files, as otherwise the new versions
of these files will not be linked. Then run:
```sh
cd ~
git clone https://github.com/Lucianod28/dotfiles
cd dotfiles
./install.sh
```
If you have any machine-specific zsh configuration you can create a `.zsh/local.sh` file and add it
there.
