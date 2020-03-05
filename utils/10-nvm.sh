#!/usr/bin/env bash

if [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"

    source "$NVM_DIR/nvm.sh"

    if [ -s "$NVM_DIR/bash_completion" ]; then
        source "$NVM_DIR/bash_completion"
    fi

    # Register as enabled.
    bu_enabled $(basename "$BASH_SOURCE")
fi
