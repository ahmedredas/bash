#!/bin/bash


if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

file_path=$1


if [ ! -e "$file_path" ]; then
    echo "Error: File not found"
    exit 1
fi


echo "File Information for: $file_path"
echo "**************************"


file_size=$(du -h "$file_path" | cut -f1)
echo "File Size: $file_size"


file_type=$(file -b "$file_path")
echo "File Type: $file_type"


file_permissions=$(ls -l "$file_path" | awk '{print $1}')
echo "File Permissions: $file_permissions"



echo "**************************"
