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

    # Get the Windows username.
    export WSL_USER="$(/mnt/c/Windows/System32/cmd.exe /c 'echo %USERNAME%' 2> /dev/null | sed -e 's/\r//g')"

    # Get the host IP address.
    export WSL_IP="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //')"

    # Set the default display server.
    if [ $WSL -eq 1 ]; then
        export DISPLAY=":0.0"
    else
        export DISPLAY="$WSL_IP:0.0"
    fi

    # Set the pulse audio server.
    export PULSE_COOKIE="/mnt/c/Users/$WSL_USER/.pulse-cookie"

    if [ $WSL -eq 1 ]; then
        export PULSE_SERVER="tcp:127.0.0.1"
    else
        export PULSE_SERVER="tcp:$WSL_IP"
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
