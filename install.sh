#!/bin/bash

# vim config
VIMDIR=$HOME/.vim
rm -rf $HOME/.config_vim $VIMDIR
git clone git@github.com:Geam/config_vim.git $VIMDIR
if [[ "$?" -eq 0 ]]; then
    git clone https://github.com/Geam/config_vim.git $VIMDIR
    cd $VIMDIR
    git submodule init && git submodule update
    mkdir $VIMDIR/tmp
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

    # update brew
    if [[ ! -e "$HOME/.brew" ]]; then
        /usr/local/bin/brew update
    fi

    # add brew cache dir
    if [[ ! -e "$HOME/Library/Caches/Homebrew" ]]; then
        mkdir -p "$HOME/Library/Caches/Homebrew"
    fi

    $HOME/.brew/bin/brew install tig htop vim
fi
