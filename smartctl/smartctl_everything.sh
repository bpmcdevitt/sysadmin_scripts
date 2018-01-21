#!/usr/bin/env bash
# smartctl all the things

echo -e "Running smartctl on drives /dev/sd[a-z]:" 
for drive in /dev/sd[a-z]; do 
    echo -n "$drive     "; smartctl -a $drive | grep 'result';
done
