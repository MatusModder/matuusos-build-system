#!/usr/bin/env bash
# download the list of packages from LFS website
wget https://linuxfromscratch.org/lfs/view/stable/wget-list
LFS=./test
bash ./2-create-file-structure.sh
if [ -f test ] then
rm -rf test
fi
mkdir $LFS/sources/
# if the wget-list exists, then remove it
if [ -f wget-list ]; then
    rm wget-list*
fi
info "downloading sources"
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
cd $LFS/sources || exit
# extract everything in this directory
for i in *.tar.*; do
    tar -xvf "$i"
done
# create a build directory in every directory thats in sources/ directory
for i in *; do
    mkdir -pvf $LFS/build/$i
done
# find ./configure script in every directory thats in sources/ directory
for i in *; do
    if [ -f $LFS/sources/"$i"/configure ]; then
        cd $LFS/sources/"$i" || exit
        info "configuring $i"
        ./configure --prefix=$LFS/build/$i
        info "building $i"
        make -j$(nproc)
        info "installing $i"
        make install
        cd $LFS/sources || exit
    fi
done