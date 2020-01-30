#!/usr/bin/env bash

if [ -f "$HOME/.phpbrew/bashrc" ]; then
    . "$HOME/.phpbrew/bashrc"
fi

# Register as enabled.
bu_enabled $(basename "$BASH_SOURCE")
