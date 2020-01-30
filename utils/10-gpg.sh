if [ "$GPG_TTY" = '' ]; then
    export GPG_TTY="$(tty)"

    # Register as enabled.
    bu_enabled $(basename "$BASH_SOURCE")
fi