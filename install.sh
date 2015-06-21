#!/bin/bash

# vim config
rm -rf $HOME/.vimrc $HOME/.vim
git clone git@github.com:Geam/config_vim.git $HOME/.vim
if [[ "$?" -eq 0 ]]; then
    cd $HOME/.vim
    git submodule init && git submodule update
    mkdir $HOME/.vim/tmp
fi

if [[ `uname` = "Darwin" ]]; then
    ln -s $PERS_PATH/exclude $HOME/.exclude
    ln -s $PERS_PATH/42_related/backup.sh $PERS_PATH/script/backup
    rm -rf Music
    ln -s /nsf/sgoinfre/goinfre/Music $HOME/Music
    if [[ ! -e "$PERS_PATH/scripts" ]]; then
        mkdir "$PERS_PATH/scripts"
    fi
fi
