#!/usr/bin/env bash

# Provide a means of tracking enabled features
function bu_enabled
{
    if [ "$BASH_UTILS_FEATURES" != "" ]; then
        BASH_UTILS_FEATURES="$BASH_UTILS_FEATURES
"
    fi

    export BASH_UTILS_FEATURES="${BASH_UTILS_FEATURES}$@"
}

# Treats the first argument as the TTY.
TTY="$1"

###
# Loads all of the scripts contained in the utils directory.
#
# This function will iterate through the utils directory in alphabetical order.
# Each shell script ending in ".sh" will be loaded into the current session for
# use.
##
if [ "$BASH_UTILS" != '' ]; then
    if [ -d "$BASH_UTILS" ]; then
        while read SCRIPT; do
            source "$SCRIPT"
        done < <(find "$BASH_UTILS/utils" -maxdepth 1 -name '*.sh' | sort)
    else
        echo "$BASH_UTILS: No such directory" >&2
    fi
else
    echo "BASH_UTILS: Environment variable not defined" >&2
fi

# Clean up the feature tracker
unset -f bu_enabled
unset TTY
