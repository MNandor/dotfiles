#!/bin/bash

cat .bashrc > ~/.nbashrc
cat .vimrc > ~/.mnvimrc
if [[ -z $(grep "nbashrc" ~/.bashrc) ]]; then
	echo "source ~/.nbashrc" >> ~/.bashrc
fi
if [[ -z $(grep "mnvimrc" ~/.vimrc) ]]; then
	echo "so ~/.mnvimrc" >> ~/.vimrc
fi
source ~/.bashrc
