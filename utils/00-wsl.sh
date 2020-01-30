#!/usr/bin/env bash

# Only run the script if inside WSL.
if grep -i Microsoft /proc/version &> /dev/null; then
    
    # Fix umask if its still an issue.
    if [ "$(umask)" = "0000" ]; then
        umask 022
    fi

    # Fix GNU_TTY for GPG agent.
    if [ ! -f ~/.gnupg/S.gpg-agent ]; then
        export GPG_TTY="$TTY"

        gpgconf --kill gpg-agent

        eval $(gpg-agent --daemon --options "$BASH_UTILS/utils/wsl/gpg-agent.conf")
    fi

    export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent:0:1"

    # Configure a default display server.
    export DISPLAY="localhost:0.0"
fi
