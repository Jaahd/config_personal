#!/bin/bash

# vim config
rm -rf $HOME/.vimrc $HOME/.vim
git clone git@github.com:Geam/config_vim.git $HOME/.vim
if [[ "$?" -eq 0 ]]; then
	cd $HOME/.vim
	git submodule init && git submodule update
	mkdir $HOME/.vim/tmp
fi
