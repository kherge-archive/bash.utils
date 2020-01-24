#!/usr/bin/env bash

# Only run the script if inside WSL.
if grep -i Microsoft /proc/version &> /dev/null; then
    
    # Fix umask if its still an issue.
    if [ "$(umask)" = "0000" ]; then
        umask 022
    fi

    # Fix GNU_TTY for GPG agent.
    if [ "$GPG_TTY" = "not a tty" ]; then
        alias gpg="GPG_TTY='$TTY' gpg"
        alias gpg="GPG_TTY='$TTY' gpg2"
    fi
fi
