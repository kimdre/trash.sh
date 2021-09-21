#!/bin/bash
# Trash Functions

[ ! -d $HOME/.trash/ ] && mkdir $HOME/.trash/
FILEPATHS_FILE="$HOME/.trash/.filepaths"
[ ! -f $FILEPATHS_FILE ] && touch $FILEPATHS_FILE

trash-list() {
    ls -lrth $HOME/.trash/
}

trash-put() {
    for i in "$@"; do
        # Store old filepath for later restore
        echo "$i $(readlink -f $i)" >> $FILEPATHS_FILE
    done
    mv -uv $* $HOME/.trash/
}

trash-empty() {
    echo "Delete all $(ls -l $HOME/.trash/* | wc -l) files in trash?"
    \rm -Ir $HOME/.trash/* && echo > $FILEPATHS_FILE
}

trash-restore() {
    for FILE_TO_RESTORE in "$@"; do
        # Get old filepath for restore
        OLDPATH=$(grep $FILE_TO_RESTORE $FILEPATHS_FILE | cut -d ' ' -f2)

        # Move file to old filepath
        mv -v $FILE_TO_RESTORE $OLDPATH

        # Replace / with \/ from string and remove filepath from file after move was successful
        sed -i "/${FILE_TO_RESTORE////\\/}/d" $FILEPATHS_FILE
    done
}

trash-rm() {
    for FILE_TO_REMOVE in "$@"; do
        if readlink -f $FILE_TO_REMOVE | grep "$HOME/.trash"; then
            \rm -Ir $HOME/.trash/$FILE_TO_REMOVE && sed -i "/$FILE_TO_REMOVE/d" $FILEPATHS_FILE
		else
            echo "$i is not in Trash." && false
        fi
    done
}

alias trash='trash-put'
alias rm='echo "This is not the command you are looking for. Use \rm instead"; false'
