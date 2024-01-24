#!/bin/bash

# Function to display script usage
usage() {
    echo "Usage: $0 <directory>"
    exit 1
}


if [ $# -eq 0 ]; then
    usage
fi

directory=$1


if [ ! -d "$directory" ]; then
    echo "Error: Directory not found"
    exit 1
fi


analyze_file() {
    file_path=$1
    echo "Analyzing file: $file_path"

    
    echo "-------- ExifTool --------"
    exiftool "$file_path"

    
    echo "-------- MediaInfo --------"
    mediainfo "$file_path"

    
    if [[ "$file_path" == *.pcap ]]; then
        echo "-------- Tcpdump --------"
        tcpdump -nn -r "$file_path"
    fi

   
    echo "-------- Strings (Steganography check) --------"
    strings "$file_path" | grep -iE "(password|flag|secret)"

    echo "---------------------------"
}

# Loop through files in the specified directory
for file in "$directory"/*; do
    if [ -f "$file" ]; then
        analyze_file "$file"
    fi
done

echo "completed successfully."
