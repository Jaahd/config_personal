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
    # add exclude file
    exclude=$HOME/.exclude
    if [[ -f $exclude ]] || [[ -h $exclude ]]; then
        rm $exclude
    fi
    ln -s $PERS_PATH/42_related/exclude $HOME/.exclude

    # create personnal script if it doesn't exist
    if [[ ! -e "$PERS_PATH/scripts" ]]; then
        mkdir "$PERS_PATH/scripts"
    fi

    # link 42 related scripts
    if [[ -h $PERS_PATH/scripts/backup ]]; then
        rm $PERS_PATH/scripts/backup
    fi
    ln -s $PERS_PATH/42_related/backup.sh $PERS_PATH/scripts/backup

    # link goindre to Music
    rm -r "$HOME/Music"
    ln -s /nfs/sgoinfre/goinfre/Music $HOME/Music
fi
