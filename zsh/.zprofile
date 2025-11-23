#!/usr/bin/env zsh
# This file is sourced only at login.

export GPG_TTY=$(tty)
eval "$(gpgconf --launch gpg-agent)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

if [[ $(uname) = "Linux" ]]; then
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec river
    fi
fi
