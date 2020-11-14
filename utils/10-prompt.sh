#!/usr/bin/env bash

# Use starship if available.
if command -v starship > /dev/null; then

    eval "$(starship init bash)"

# Use hand-built PS1 prompt.
else

    # Please refer to this documentation on available BASH prompt options:
    # http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html

    export PS1="\[$(color -fdark-gray)\][\t]\[$(color -r)\] \[$(color -fgreen)\]\W\[$(color -r)\] \[$(color -fmagenta)\]\$\[$(color -r)\] "
fi

# Register as enabled.
bu_enabled $(basename "$BASH_SOURCE")
