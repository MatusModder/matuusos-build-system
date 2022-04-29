#!/usr/bin/env bash
error "Please enter a path to config file"
# check if there is at least 12GB of storage
export lsblk_size=$(lsblk -o SIZE -d | awk '{sum+=$1} END {print sum}')
if [ "$lsblk_size" -lt 12000000000 ]; then
    error "There is not enough storage"
    exit 1
fi
