#!/usr/bin/env bash

###
# Generates a new PATH value.
#
# This function will iterate through the $BASH_UTILS/utils/path directory and
# generate a list of paths using the contents of each file. If a path is found
# in PATH, it will not be added again.
##
function bu_path
{
    local NEW_PATH="$PATH"

    while read FILE; do
        WANTED_PATH="$(cat "$FILE")"
        WANTED_PATH="$(eval "echo \"$WANTED_PATH\"")"

        if [ -d "$WANTED_PATH" ] && [[ $NEW_PATH != *"$WANTED_PATH"* ]]; then
            NEW_PATH="$WANTED_PATH:$NEW_PATH"
        fi
    done < <(find "$BASH_UTILS/utils/path" -maxdepth 1 -type f)

    echo "$NEW_PATH"
}

export PATH="$(bu_path)"

unset -f bu_path