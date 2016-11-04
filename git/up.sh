#!/bin/bash
DIR=$(cd "$(dirname "$0")" ; pwd -P)

rm -f $HOME/.zshrc.d/git.zsh && ln -s $DIR/.zshrc $HOME/.zshrc.d/git.zsh
git config --global include.path $DIR/.gitconfig

