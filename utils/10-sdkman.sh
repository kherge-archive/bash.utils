#!/usr/bin/env bash

export SDKMAN_DIR="$HOME/.sdkman"

if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

# Register as enabled.
bu_enabled $(basename "$BASH_SOURCE")