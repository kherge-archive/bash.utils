#!/usr/bin/env bash

if [ "$GPG_TTY" = '' ] || [ "$GPG_TTY" = 'not a tty' ]; then
    export GPG_TTY="$TTY"

    if command -v gpgconf > /dev/null; then
        # Enable support for SSH using PGP key.
        if [ ! -f "$HOME/.gnupg/gpg-agent.conf" ] \
            || ! grep -F enable-ssh-support "$HOME/.gnupg/gpg-agent.conf" > /dev/null; then
            echo enable-ssh-support >> "$HOME/.gnupg/gpg-agent.conf"
        fi

        # Export the path to the GPG agent socket connection.
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

        # WTF
        # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=835394
        gpg-connect-agent updatestartuptty /bye > /dev/null

        # Restart the GPG agent.
        gpgconf --launch gpg-agent
    fi

    # Register as enabled.
    bu_enabled $(basename "$BASH_SOURCE")
fi