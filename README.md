# trash.sh - A trash bin for files and directories instead of deleting them directly

[![Build Status](https://drone.pyas.de/api/badges/Kim/trash.sh/status.svg)](https://drone.pyas.de/Kim/trash.sh)

## Installation:  
Put the trash.sh file to your desired location (e.g home directory) and source it in your $HOME/.bashrc or in /etc/.bashrc:

    . /path/to/trash.sh

- When the script runs, it first checks if `$HOME/.trash/` (your trash bin) exists and creates it if missing.

Add the cleanup job to your crontab:

    # .trash cleanup of all contents (files and dirs) older than 31 days every morning at 06:00
    0 6 * * 0 find $HOME/.trash/ -mtime +31 -delete  

## Usage: 

 - `trash FILE1 DIR2 ...` or `trash_put FILE1 DIR2 ...` to move files and directories with relative or absolute paths to your .trash
 - `trash_list` to list all files and dirs that you put in the trash in the last 30 days
 - `trash_empty` to remove all files and dirs in your trash
 - `trash_rm FILE1 DIR2 ...` to delete specific files and directories in your trash
 - `trash_restore FILE1 DIR2 ...`  to restore specific files and directories from your trash to it's origin

## Credits
Repo Icon made by [Freepik](https://www.freepik.com "Freepik") from [www.flaticon.com](https://www.flaticon.com/ "Flaticon")
