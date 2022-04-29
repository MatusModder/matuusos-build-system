#!/usr/bin/env bash
message() {
    echo -e "\033[32m[INFO]\033[0m $1"
}
warnings() {
    echo -e "\033[33m[WARNING]\033[0m $1"
}
error() {
    echo -e "\033[31m[ERROR]\033[0m $1"
}
# if not entere a path to config, thenm exit
if [ -z "$1" ]; then
    error "Please enter a path to config file"
    exit 1
fi
export message "$1"
export warnings "$1"
export error "$1"