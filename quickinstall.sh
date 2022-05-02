#!/bin/bash

cat .bashrc > ~/.nbashrc
cat .vimrc > ~/.nvimrc
echo "so ~/.nvimrc" >> ~/.vimrc
echo "source ~/.nbashrc" >> ~/.bashrc
source ~/.bashrc
