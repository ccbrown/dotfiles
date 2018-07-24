#!/bin/bash
DIR=$(cd "$(dirname "$0")" ; pwd -P)

brew list neovim &> /dev/null
if [ $? -eq 0 ]; then
    brew tap neovim/neovim
    brew outdated neovim/neovim/neovim || brew upgrade neovim/neovim/neovim
else
    brew install neovim/neovim/neovim
fi

mkdir -p ~/.vim ~/.vimbackups

rm -rf ~/.config/nvim && ln -s ~/.vim ~/.config/nvim
rm -f ~/.config/nvim/init.vim && ln -s ~/.vimrc ~/.config/nvim/init.vim
rm -f $HOME/.vimrc && ln -s $DIR/.vimrc $HOME/.vimrc

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c ':PlugInstall' -c ':qa'

rm -f $HOME/.zshrc.d/vim.zsh && ln -s $DIR/.zshrc $HOME/.zshrc.d/vim.zsh

nvim -c ':GoInstallBinaries' -c ':qa'
