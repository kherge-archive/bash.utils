#!/usr/bin/env bash

# Only run the script if inside WSL.
if grep -i Microsoft /proc/version &> /dev/null; then
    
    # Fix umask if its still an issue.
    if [ "$(umask)" = "0000" ]; then
        umask 022
    fi
fi