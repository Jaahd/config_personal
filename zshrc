# Tmux command history
bindkey '^R' history-incremental-search-backward
bindkey -e
export LC_ALL=en_US.UTF-8

# default editor
EDITOR=/usr/bin/vim
export EDITOR

# Reglage du terminal
if [ "$SHLVL" -eq 1 ]; then
    TERM=xterm-256color
fi

# search in history based on what is type
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# ctrl + arrow in archlinux
bindkey '^[Od' backward-word
bindkey '^[Oc' forward-word

# Definition des couleurs
if [ -f ~/.ls_colors ]; then
    source ~/.ls_colors
fi

# Couleurs pour le man
man()
{
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

if [[ "$C_SYS" = "Darwin" ]]; then
    # OPAM configuration
    if [[ -f $HOME/.opam/opam-init/init.zsh ]]; then
        source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
    fi

    if [ ! -e $HOME/nosync ]; then
        mkdir $HOME/nosync
    fi

    if [[ -f $C_PATH_TO_PERSONNAL_CONFIG/42_related/ssh_config ]]; then
        if [[ -z `cat $HOME/.ssh/config | grep geam 2> /dev/null` ]]; then
            cat $C_PATH_TO_PERSONNAL_CONFIG/42_related/ssh_config >> $HOME/.ssh/config
        fi
    fi
fi
