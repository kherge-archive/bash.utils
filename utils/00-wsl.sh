#!/usr/bin/env bash

# Only run the script if inside WSL.
if grep -i Microsoft /proc/version &> /dev/null; then
    
    # Fix umask if its still an issue.
    if [ "$(umask)" = "0000" ]; then
        umask 022
    fi

    # Configure a default display server.
    export HOST_IP="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //')"
    export DISPLAY="$HOST_IP:0.0"

    # Register as enabled.
    bu_enabled $(basename "$BASH_SOURCE")
fi

