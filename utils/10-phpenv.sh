#!/usr/bin/env bash

if command -v phpenv > /dev/null; then
    eval "$(phpenv init -)"

    # Register as enabled.
    bu_enabled $(basename "$BASH_SOURCE")
fi