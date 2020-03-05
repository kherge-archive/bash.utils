#!/usr/bin/env bash

if [ "$GPG_TTY" = '' ] || [ "$GPG_TTY" = 'not a tty' ]; then
    export GPG_TTY="$TTY"

    # Register as enabled.
    bu_enabled $(basename "$BASH_SOURCE")
fi