#!/usr/bin/env bash

set -e

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/utils.sh"

default_caps_lock_on_value="CAPS"
default_caps_lock_off_value="    "

default_caps_lock_on_fg=
default_caps_lock_on_bg=
default_caps_lock_off_fg=
default_caps_lock_off_bg=

default_caps_lock_on_prefix=
default_caps_lock_on_suffix=
default_caps_lock_off_prefix=
default_caps_lock_off_suffix=

function main() {
    local caps_lock_on_value="$(tmux-option "@caps_lock_on_value" "$default_caps_lock_on_value")"
    local caps_lock_off_value="$(tmux-option "@caps_lock_off_value" "$default_caps_lock_off_value")"

    local caps_lock_on_fg="$(tmux-option "@caps_lock_on_fg" "$default_caps_lock_on_fg")"
    local caps_lock_on_bg="$(tmux-option "@caps_lock_on_bg" "$default_caps_lock_on_bg")"
    local caps_lock_off_fg="$(tmux-option "@caps_lock_off_fg" "$default_caps_lock_off_fg")"
    local caps_lock_off_bg="$(tmux-option "@caps_lock_off_bg" "$default_caps_lock_off_bg")"

    local caps_lock_on_prefix="$(tmux-option "@caps_lock_on_prefix" "$default_caps_lock_on_prefix")"
    local caps_lock_on_suffix="$(tmux-option "@caps_lock_on_suffix" "$default_caps_lock_on_suffix")"
    local caps_lock_off_prefix="$(tmux-option "@caps_lock_off_prefix" "$default_caps_lock_off_prefix")"
    local caps_lock_off_suffix="$(tmux-option "@caps_lock_off_suffix" "$default_caps_lock_off_suffix")"

    local status="$(xset -q | sed -rn 's/.*\s+Caps Lock:\s+(on|off)\s+.*/\1/p')"

    if [[ $status = "on" ]]; then
        echo "#[fg=$caps_lock_on_fg]#[bg=$caps_lock_on_bg]${caps_lock_on_prefix}${caps_lock_on_value}${caps_lock_on_suffix}#[default]"
    else
        echo "#[fg=$caps_lock_off_fg]#[bg=$caps_lock_off_bg]${caps_lock_off_prefix}${caps_lock_off_value}${caps_lock_off_suffix}#[default]"
    fi
}

main
