#!/bin/bash

cat .bashrc > ~/.nbashrc
cat .vimrc > ~/.nvimrc
if [[ -z $(grep "nbashrc" ~/.bashrc) ]]; then
	echo "source ~/.nbashrc" >> ~/.bashrc
fi
if [[ -z $(grep "nvimrc" ~/.vimrc) ]]; then
	echo "so ~/.nvimrc" >> ~/.vimrc
fi
source ~/.bashrc
