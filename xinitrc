#!/bin/sh

# Start ssh-agent if it's not alreaddy running
[ -n "$SSH_AUTH_SOCK" ] || eval `ssh-agent`