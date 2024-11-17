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

default_caps_lock_on_attr=
default_caps_lock_off_attr=

function main() {
    local on_value="$(tmux-option "@caps_lock_on_value" "$default_caps_lock_on_value")"
    local off_value="$(tmux-option "@caps_lock_off_value" "$default_caps_lock_off_value")"

    local on_fg_color="$(tmux-option "@caps_lock_on_fg" "$default_caps_lock_on_fg")"
    local on_bg_color="$(tmux-option "@caps_lock_on_bg" "$default_caps_lock_on_bg")"
    local off_fg_color="$(tmux-option "@caps_lock_off_fg" "$default_caps_lock_off_fg")"
    local off_bg_color="$(tmux-option "@caps_lock_off_bg" "$default_caps_lock_off_bg")"

    local on_attr_opts="$(tmux-option "@caps_lock_on_attr" "$default_caps_lock_on_attr")"
    local off_attr_opts="$(tmux-option "@caps_lock_off_attr" "$default_caps_lock_off_attr")"

    on_fg="${on_fg_color:+#[fg=${on_fg_color}]}"
    on_bg="${on_bg_color:+#[bg=${on_bg_color}]}"
    off_fg="${off_fg_color:+#[fg=${off_fg_color}]}"
    off_bg="${off_bg_color:+#[bg=${off_bg_color}]}"

    on_attr="${on_attr_opts:+#[default]#[${on_attr_opts}]}"
    off_attr="${off_attr_opts:+#[default]#[${off_attr_opts}]}"

    local status="$(xset -q | sed -rn 's/.*\s+Caps Lock:\s+(on|off)\s+.*/\1/p')"

    if [[ $status = "on" ]]; then
        echo "${on_attr}${on_fg}${on_bg}${on_value}#[default]"
    else
        echo "${off_attr}${off_fg}${off_bg}${off_value}#[default]"
    fi
}

main
