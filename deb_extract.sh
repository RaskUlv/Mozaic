#!/bin/bash

file=$1
fullname=$(basename "$file")
filename=${fullname%.*}
filedir=$(dirname "$file")
workdir="$filedir/$filename"
mkdir "$workdir"
mkdir "$workdir/DEBIAN"
dpkg-deb -x "$file" "$workdir"
dpkg-deb -e "$file" "$workdir/DEBIAN"
