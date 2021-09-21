# trash - A trash bin for files and directories instead of deleting them directly

## Installation:  
Place the file in your desired path and it in your $HOME/.bashrc or in /etc/.bashrc:

    source /path/to/trash.sh

Add cleanup job to your cron:

    # .trash cleanup of all contents (files and dirs) older than 31 days every morning at 06:00
    0 6 * * 0 find /home/YOURHOME/.trash/ -mtime +31 -delete  

## Usage: 
As the Script runs it first checks if $HOME/.trash/ (your trash bin) in your home dir exists and creates it if missing.

 - `trash FILE1 DIR2 ...` or `trash-put FILE1 DIR2 ...` to move files and directories with relative or absolute paths to your .trash
 - `trash-list` to list all files and dirs that you put in the trash in the last 30 days
 - `trash-empty` to remove all files and dirs in your trash
 - `trash-rm FILE1 DIR2 ...` to delete specific files and directories in your trash
 - `trash-restore FILE1 DIR2 ...`  to restore specific files and directories from your trash to it's origin
