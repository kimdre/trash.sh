# trash - A trash bin for files and directories instead of deleting them directly

[![Build Status](https://drone.pyas.de/api/badges/Kim/trash/status.svg)](https://drone.pyas.de/Kim/trash)

## Installation:  
the trash.sh file in your desired path and source it in your $HOME/.bashrc or in /etc/.bashrc:

    . /path/to/trash.sh

- As the Script runs it first checks if $HOME/.trash/ (your trash bin) in your home dir exists and creates it if missing.

Add cleanup job to your cron:

    # .trash cleanup of all contents (files and dirs) older than 31 days every morning at 06:00
    0 6 * * 0 find /home/YOURHOME/.trash/ -mtime +31 -delete  

## Usage: 

 - `trash FILE1 DIR2 ...` or `trash_put FILE1 DIR2 ...` to move files and directories with relative or absolute paths to your .trash
 - `trash_list` to list all files and dirs that you put in the trash in the last 30 days
 - `trash_empty` to remove all files and dirs in your trash
 - `trash_rm FILE1 DIR2 ...` to delete specific files and directories in your trash
 - `trash_restore FILE1 DIR2 ...`  to restore specific files and directories from your trash to it's origin
