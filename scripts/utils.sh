tmux-option() {
    local value="$(tmux show-option -gqv "$1")"
    local default="$2"

    if [[ -n $value ]]; then
        echo "$value"
    else
        echo "$default"
    fi
}

