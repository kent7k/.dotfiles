#!/bin/bash

cd ~
ln -snfv ~/.dotfiles/.bash/.bashrc ~/.bashrc
source ~/.bashrc
echo "DOT_FILES is set to: $DOT_FILES"
