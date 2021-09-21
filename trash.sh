#!/bin/bash
# Trash Functions

TRASH_DIR="$HOME"/.trash

[ ! -d "$TRASH_DIR" ] && mkdir "$TRASH_DIR"
FILE_PATHS_FILE="$TRASH_DIR/.filepaths"
[ ! -f "$FILE_PATHS_FILE" ] && touch "$FILE_PATHS_FILE"

trash_list() {
  find "$TRASH_DIR" ! -name ".filepaths" | tail -n +2
}

trash_put() {
  for FILE in $@; do
    # Store old filepath for later restore
    echo "$FILE $(readlink -f "$FILE")" >>"$FILE_PATHS_FILE"
  done
  mv -v $* "$TRASH_DIR/"
}

trash_empty() {
  \rm -rf "${TRASH_DIR/*}" && echo >"$FILE_PATHS_FILE"
  echo "Deleted $(find "$TRASH_DIR" ! -name ".filepaths" | tail -n +2 | wc -l) files in trash"
}

trash_restore() {
  for FILE_TO_RESTORE in "$@"; do
    # Get old filepath for restore
    OLD_PATH=$(grep "$FILE_TO_RESTORE" "$FILE_PATHS_FILE" | cut -d ' ' -f2)

    # Move file to old filepath
    mv -v "${TRASH_DIR}/${FILE_TO_RESTORE}" "$OLD_PATH"

    # Replace / with \/ from string and remove filepath from file after move was successful
    sed -i "/${FILE_TO_RESTORE////\\/}/d" "$FILE_PATHS_FILE"
  done
}

trash_rm() {
  for FILE_TO_REMOVE in "$@"; do
    if ! echo "$FILE_TO_REMOVE" | grep "$HOME/.trash"
      then FILEPATH_TO_REMOVE="$HOME/.trash/$FILE_TO_REMOVE"
      else FILEPATH_TO_REMOVE="$FILE_TO_REMOVE"
    fi
    if [ -f "$FILEPATH_TO_REMOVE" ]; then
      \rm -irf "$FILEPATH_TO_REMOVE" && sed -i "/$FILE_TO_REMOVE/d" "$FILE_PATHS_FILE"
    else
      echo "$FILE_TO_REMOVE is not in Trash." && false
    fi
  done
}

alias trash='trash_put'
alias rm='echo "This is not the command you are looking for. Use \rm instead"; false'
