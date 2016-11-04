#!/bin/bash
DIR=$(cd "$(dirname "$0")" ; pwd -P)

rm -f $HOME/.zshrc && ln -s $DIR/.zshrc $HOME/.zshrc
mkdir -p $HOME/.zshrc.d

ZSH=$(which zsh)
if [ "$SHELL" != "$ZSH" ]; then
    chsh -s "$ZSH"
fi
