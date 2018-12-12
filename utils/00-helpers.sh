#!/usr/bin/env bash

###
# Exits if the command does return status `0` (zero).
#
# @param $command,... The command line arguments.
##
function must
{
    "$@";

    local STATUS=$?

    if [ $STATUS -ne 0 ]; then
        exit $STATUS
    fi
}

###
# Writes to STDERR.
#
# @param $input,... The input to write.
##
function warn
{
    if [ "$1" = '' ]; then
        cat - >&2
    else
        echo "$@" >&2
    fi
}