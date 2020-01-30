#!/usr/bin/env bash

if [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"

    source "$NVM_DIR/nvm.sh"

    # Register as enabled.
    bu_enabled $(basename "$BASH_SOURCE")
fi