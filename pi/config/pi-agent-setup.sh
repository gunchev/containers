#!/usr/bin/env bash
# Seed ~/.pi/agent/settings.json from /etc/skel the first time a user runs an
# interactive shell in this toolbox. Toolbox 0.3's init-container only copies
# top-level /etc/skel files (e.g. .bashrc), not nested hidden directories,
# so /etc/skel/.pi/agent/settings.json would otherwise sit unused.
# Idempotent: only acts when the destination file is missing.

if [ -n "${HOME:-}" ] && [ ! -e "${HOME}/.pi/agent/settings.json" ] \
        && [ -r /etc/skel/.pi/agent/settings.json ]; then
    mkdir -p "${HOME}/.pi/agent" "${HOME}/.local/share/pi" "${HOME}/.config/pi"
    install -m 0644 /etc/skel/.pi/agent/settings.json "${HOME}/.pi/agent/settings.json"
fi
