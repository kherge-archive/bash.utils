#!/usr/bin/env bash

# Check what version of WSL we are running in.
if uname -a | grep -i microsoft > /dev/null; then
    if [ -d /run/WSL ]; then
        export WSL=2
    else
        export WSL=1
    fi
else
    export WSL=0
fi

# Make changes only in WSL.
if [ $WSL -gt 0 ]; then

    # Fix umask if its still an issue.
    if [ "$(umask)" = "0000" ]; then
        umask 022
    fi

    # Set the default display server.
    if [ $WSL -eq 1 ]; then
        export DISPLAY=":0.0"
    else
        export DISPLAY="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0.0"
    fi

    # Go home if starting directory is /mnt/c.
    if [[ "$(pwd)" =~ /mnt/c* ]]; then
        cd "$HOME"
    fi

    # Define a function to simplify launching GUI apps.
    function gui
    {
        # Check usage.
        if [ "$1" = '' ]; then
            echo "Usage: gui COMMAND
Launches a GUI application in the background.

ARGUMENTS

    COMMAND The command line arguments to launch the app.
"
            return 0
        fi

        # Make sure the X server is running.
        if ! nc -z "$(echo "$DISPLAY" | cut -d: -f1)" 6000 -w 3; then
            echo "The remote X server is not running."
            echo
            read -s -n 1 -p "Press any key to continue..."
        fi

        # Create a log file.
        local LOG="$(tempfile -d /tmp/gui)"

        # Launch the app.
        nohup "$@" &> "$LOG" &
    }

    # Register as enabled.
    bu_enabled $(basename "$BASH_SOURCE")
fi
