#!/bin/bash
# Trash Functions

[ ! -d "$HOME"/.trash/ ] && mkdir "$HOME"/.trash/
FILE_PATHS_FILE="$HOME/.trash/.filepaths"
[ ! -f "$FILE_PATHS_FILE" ] && touch "$FILE_PATHS_FILE"

trash_list() {
  find "$HOME"/.trash/ ! -name ".filepaths"
}

trash_put() {
  for FILE in $@; do
    # Store old filepath for later restore
    echo "$FILE $(readlink -f "$FILE")" >>"$FILE_PATHS_FILE"
  done
  mv -v $* "$HOME"/.trash/
}

trash_empty() {
  echo "Delete all $(find "$HOME"/.trash/ ! -name ".filepaths" | wc -l) files in trash?"
  # shellcheck disable=SC2086
  \rm -Ir $HOME/.trash/* && echo >"$FILE_PATHS_FILE"
}

trash_restore() {
  for FILE_TO_RESTORE in "$@"; do
    # Get old filepath for restore
    OLD_PATH=$(grep "$FILE_TO_RESTORE" "$FILE_PATHS_FILE" | cut -d ' ' -f2)

    # Move file to old filepath
    mv -v "$FILE_TO_RESTORE" "$OLD_PATH"

    # Replace / with \/ from string and remove filepath from file after move was successful
    sed -i "/${FILE_TO_RESTORE////\\/}/d" "$FILE_PATHS_FILE"
  done
}

trash_rm() {
  for FILE_TO_REMOVE in "$@"; do
    if ! [[ "$FILE_TO_REMOVE" =~ $HOME/.trash ]]
      then FILE_TO_REMOVE="$HOME/.trash/$FILE_TO_REMOVE"
    fi
    if find "$FILE_TO_REMOVE" >& /dev/null; then
      \rm -Ir "$HOME"/.trash/"$FILE_TO_REMOVE" && sed -i "/$FILE_TO_REMOVE/d" "$FILE_PATHS_FILE"
    else
      echo "$FILE_TO_REMOVE is not in Trash." && false
    fi
  done
}

alias trash='trash_put'
alias rm='echo "This is not the command you are looking for. Use \rm instead"; false'
