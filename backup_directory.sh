#!/bin/bash

# Set the source and destination directories
source_directory="/home"
backup_directory="/path/to/backup"

# Check if the backup directory exists, if not, create it
if [ ! -d "$backup_directory" ]; then
    mkdir -p "$backup_directory"
fi

# Set the backup filename with timestamp
backup_filename="home_backup_$(date +'%Y%m%d_%H%M%S').tar.gz"
backup_path="$backup_directory/$backup_filename"

# Perform the backup using tar
tar -czvf "$backup_path" "$source_directory"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
    echo "Backup saved to: $backup_path"
else
    echo "Error: Backup failed."
fi
