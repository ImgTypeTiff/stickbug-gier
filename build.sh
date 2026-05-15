#!/bin/bash


DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

out_path="${DIR}/out"
work_path="${DIR}/work"

echo "Work folder path: ${work_path}"
echo "Out folder path: ${out_path}"

mkdir -p $out_path
mkdir -p $work_path

if [ "$(id -u)" -ne 0 ]; then
    echo "build has to be run as root."
    exit 1
fi

shopt -s nullglob
shopt -s dotglob
files=(${work_path}/*)
if [ ${#files[@]} -eq 0 ]; then
    echo "work is empty, continuing to out check..."
else
    echo "work is not empty, deleting contents..."
    sudo rm -r ${work_path}/*
fi
shopt -u nullglob dotglob


shopt -s nullglob
shopt -s dotglob
files=(${out_path}/*)
if [ ${#files[@]} -eq 0 ]; then
    echo "out is empty, continuing to mkarchiso..."
else
    echo "out is not empty, moving ISO files to ~/stickbuggier-out, deleting other files."
    mkdir -p ~/stickbuggier-out
    cd $out_path
    mv *.iso ~/stickbuggier-out
    rm -r $out_path/*
fi
shopt -u nullglob dotglob

echo "
"
#sudo rm -r work/* out/*
sudo mkarchiso -v -w work -o out .
