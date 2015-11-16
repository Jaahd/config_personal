#!/bin/bash

# time between synchro in seconds
sleep=1800

if [[ `ps x | grep -v grep | grep "/bin/bash $0" | wc -l` -gt 2 ]]; then
    exit 0
fi

chrono=$sleep

trap do_sync SIGUSR1
do_sync() {
    rsync -rl $OHOME/ $HOME/
    chrono=$sleep
}

while true
do
    if [[ chrono -eq 0 ]]
    then
        do_sync
    else
        chrono=`expr $chrono - 1`
    fi
    sleep 1
done
