#!/bin/sh
# Emergency (Super+Shift+Tab): kill a stuck command center and start a fresh daemon.
# Own file + python-anchored pattern, so it never matches a shell or an editor with this path open.
# Matches both command_center.py and the ~/.local/bin/command-center symlink.
pkill -9 -f '^python[0-9.]* [^ ]*command[_-]center(\.py)?( |$)'
sleep 0.3
exec "$(dirname "$(readlink -f "$0")")/command_center.py" --daemon
