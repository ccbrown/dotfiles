#!/bin/bash
DIR=$(cd "$(dirname "$0")" ; pwd -P)

mkdir -p $HOME/.claude
ln -s $DIR/CLAUDE.md $HOME/.claude/CLAUDE.md
