#!/bin/bash

# clean variables uses below
unset backup_compress backup_extract backup_send backup_download \
    backup_remove

# go in home directory
cd

# set variables
nosync_name="nosync"
nosync="$HOME/$nosync_name"
tar_name="backup.tgz"
tarfile="$nosync/$tar_name"

function usage () {
    echo "backup <options>"
    echo "Options list"
    echo "\t-c|--compress: compress all files in \$HOME/.exclude but "\
        "$nosync_name"
    echo "\t-x|--extract: extract backup files"
    echo "\t-u|--upload: send backup to server"
    echo "\t-d|--download: download backup from server"
    echo "\t-r|--remove-backup: remove local backup"
    if [[ -n "$1" ]]
    then
        exit $1
    else
        exit 0
    fi
}

if [[ -z "$1" ]]; then
    usage
fi

while test $# -gt 0
do
    case $1 in
        -h|--help)
            usage
            ;;
        -c|--compress)
            backup_compress="OK"
            ;;
        -x|--extract)
            backup_extract="OK"
            ;;
        -u|--upload)
            backup_send="OK"
            ;;
        -d|--download)
            backup_download="OK"
            ;;
        -r|--remove-backup)
            backup_remove="OK"
            ;;
        *)
            echo "$1: unsupported option"
            usage 1
            ;;
    esac
    shift
done

if [[ -n "$backup_compress" ]]; then
    backup_files=`cat $HOME/.exclude | grep -v $nosync_name`
    if [[ -f "$tarfile" ]]; then
        rm $tarfile
    fi
    tar czf $tarfile "$nosync/$backup_files"
fi

if [[ -n "$backup_extract" ]]; then
    if [[ -f "$tarfile" ]]; then
        tar xzf $tarfile
    fi
fi

if [[ -n "$backup_send" ]]; then
    if [[ -f "$tarfile" ]]; then
        scp $tarfile "geam-creadl.net:/home/geam/42_backup/"
    fi
fi

if [[ -n "$backup_download" ]]; then
    if [[ -f "$tarfile" ]]; then
        rm $tarfile
    fi
    scp "geam-creadl.net:/home/geam/42_backup/$tar_name" $nosync
fi

if [[ -n "$backup_remove" ]]; then
    if [[ -f "$tarfile" ]]; then
        rm $tarfile
    fi
fi
