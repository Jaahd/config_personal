#!/bin/bash

# clean variables uses below
unset backup_compress backup_extract backup_send backup_download \
    backup_remove

# go in home directory
cd

# set variables
tar_list_dir="$C_PATH_TO_PERSONNAL_CONFIG/42_related/sync"
tar_list=`ls $tar_list_dir`
tar_dir_name=".tar_dir"
tar_dir="$HOME/$tar_dir_name"
if [[ ! -d $tar_dir ]]; then
    mkdir $tar_dir
fi

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
    echo "== Start compressing process =="
    for tar_name in $tar_list
    do
        echo -n "$tar_name"
        tar_file=$tar_dir/$tar_name.tgz
        tar_timestamp=`stat -f "%m" $tar_file`
        if [[ -f $tar_file ]]; then unset ok; else ok=ok; fi
        files_list=`cat $tar_list_dir/$tar_name`
        for file in $files_list
        do
            if [[ `stat -f "%m" $file` -gt $tar_timestamp ]]; then
                ok=ok
            fi
        done
        if [[ -n "$ok" ]]; then
            echo " new to be update"
            rm -f $tar_file
            tar czf $tar_file $files_list
        else
            echo " doesn't need to be update"
        fi
    done
    echo "== End of compressing process =="
fi

if [[ -n "$backup_send" ]]; then
    echo "== Send backup to server =="
    for tar_name in $tar_list
    do
        tar_file=$tar_dir/$tar_name.tgz
        if [[ -f "$tarfile" ]]; then
            scp $tarfile "geam-creadl.net:/home/geam/42_backup/"
        fi
    done
    echo "== Send done =="
fi

if [[ -n "$backup_download" ]]; then
    echo "== Download backup from server =="
    for tar_name in $tar_list
    do
        tar_file=$tar_dir/$tar_name.tgz
        if [[ -f "$tarfile" ]]; then
            rm $tarfile
        fi
        scp "geam-creadl.net:/home/geam/42_backup/$tar_name" $nosync
    done
    echo "== Download done =="
fi

if [[ -n "$backup_extract" ]]; then
    echo "== Extracting backup tar =="
    for tar_name in $tar_list
    do
        echo "Extracting $tar_name"
        tar_file=$tar_dir/$tar_name.tgz
        if [[ -f "$tarfile" ]]; then
            files_list=`cat $tar_list_dir/$tar_name`
            rm -rf $backup_files
            tar xzf $tarfile
        fi
    done
    echo "== End of extracting =="
fi
