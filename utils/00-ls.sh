#!/usr/bin/env bash

###
# Generates an `ls` command with the desired options.
#
# This function will iterate through the desired options to check if the
# available `ls` command supports them. If the option is listed in the help
# message, it will be included with the output for the `ls` command.
##
function bu_ls_command
{
    COMMAND="ls"
    HELP="$(ls --help)"
    OPTIONS=(
        --color=auto
        --group-directories-first
        --hide-control-chars
        -l
    )

    for OPTION in "${OPTIONS[@]}"; do
        if [[ $HELP == *$OPTION* ]]; then
            COMMAND="$COMMAND $OPTION"
        fi
    done

    echo "$COMMAND"
}

# Create an alias with the desired options.
alias ll="$(bu_ls_command) -Isnap"

unset -f bu_ls_command

# Create an alias to display hidden files.
alias la='ll -a'

# Create an alias to display human friendly file sizes.
alias lh='ll -h'

# Register as enabled.
bu_enabled $(basename "$BASH_SOURCE")
