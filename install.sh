#!/bin/bash

# vim config
VIMDIR=$HOME/.nvim
CONFIG_VIM=$HOME/.config_neovim
VIM_DEPOT=github.com/Geam/config_neovim.git
rm -rf $HOME/.config_vim $VIMDIR
git clone "git@$VIM_DEPOT" $CONFIG_VIM
# because some person keep using my personnal config instead of doing their own,
# they need to use the https version of this repo
if [[ "$?" -ne 0 ]]; then
    git clone "https://$VIM_DEPOT" $CONFIG_VIM
    cd $CONFIG_VIM
fi
mkdir $CONFIG_VIM/tmp
if [[ ! -e $HOME/.config ]]; then
    mkdir $HOME/.config
fi

if [[ "$USER" != "geam" ]] && [[ "$USER" != "mdelage" ]]; then
    # remove my git config if it's not me
    sed -i.back '/git/d' $PERS_PATH/ln
fi

if [[ `uname` = "Darwin" ]]; then
    # create personnal script if it doesn't exist
    if [[ ! -e "$PERS_PATH/scripts" ]]; then
        mkdir "$PERS_PATH/scripts"
    fi

    # link goindre to Music
    rm -r "$HOME/Music"
    ln -s /nfs/sgoinfre/goinfre/Music $HOME/Music
fi
