if [ "$GPG_TTY" = '' ]; then
    export GPG_TTY="$(tty)"
fi
