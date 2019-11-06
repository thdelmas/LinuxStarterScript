#!/bin/sh

VIM_DIR="$HOME/.vim"
PATHOGEN_GIT="https://github.com/tpope/vim-pathogen.git"
VIM_RC="$HOME/.vimrc"
if [ ! -e "$VIM_DIR" ]
then
	mkdir "$VIM_DIR"
elif [ ! -d "$VIM_DIR" ]
then
	return 1
fi
if [ -d "$VIM_DIR" ] && [ ! -e "$VIM_DIR/vim-pathogen" ]
then
	mkdir -p "$VIM_DIR/autoload"
	mkdir -p "$VIM_DIR/bundle"
	git clone "$PATHOGEN_GIT" "$VIM_DIR/vim-pathogen"
	cp "$VIM_DIR/vim-pathogen/autoload/pathogen.vim" "$VIM_DIR/autoload/pathogen.vim"
	if [ ! -e "$VIM_RC" ]
	then
		echo 'set nocompatible' >> "$VIM_RC"
		echo 'filetype plugin indent on' >> "$VIM_RC"
		echo 'set number' >> "$VIM_RC"
		echo 'syntax on' >> "$VIM_RC"
	fi
	echo 'execute pathogen#infect()' >> "$VIM_RC"
fi

