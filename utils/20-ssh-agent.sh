#!/usr/bin/env bash

# Run the SSH agent if it isn't running.
if ! ps -ef | grep ssh-agent | grep -v grep > /dev/null; then
    eval "$(ssh-agent -s)"
fi