#!/usr/bin/env bash

set -e

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/scripts/utils.sh"

caps_lock_placeholder="\#{caps_lock}"

main() {
    local status_left="$(tmux-option "status-left")"
    local status_right="$(tmux-option "status-right")"

    local caps_lock="#(${HERE}/scripts/caps_lock_format.sh)"

    tmux set-option -g "status-right" "${status_right//$caps_lock_placeholder/$caps_lock}"
    tmux set-option -g "status-left" "${status_left//$caps_lock_placeholder/$caps_lock}"
}

main
