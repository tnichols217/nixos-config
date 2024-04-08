#!/usr/bin/env bash

matrix_size=5
matrix_max=$(($matrix_size ** 2))
max_screens=10

## Functions
function reload_waybar {
	kill -SIGRTMIN+1 $(pgrep waybar)
}

function x_value {
	echo $(($1 % $matrix_size))
}

function y_value {
	echo $(($1 / $matrix_size))
}

function moveWorkspace {
    direction=$1
    screen=$2
    x=$3
    y=$4
    case "$direction" in
        "left" | "move_left") x=$((($x + $matrix_size - 1) % $matrix_size));  ;;
        "right" | "move_right") x=$((($x + 1) % $matrix_size)) ;;
        "up" | "move_up") y=$((($y + $matrix_size - 1) % $matrix_size)) ;;
        "down" | "move_down") y=$((($y + 1) % $matrix_size)) ;;
        "query") echo "($x,$y)"; exit ;;
    esac

    ws=$(($max_screens * ($y * $matrix_size + $x) + $active_monitor + 1))

    case "$direction" in
        "left" | "right" | "up" | "down") hyprctl dispatch workspace $ws ;;
        "move_left" | "move_right" | "move_up" | "move_down") hyprctl dispatch movetoworkspace $ws ;;
    esac
}

## Get active workspace and translate to x / y
active_ws=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')
active_ws=$((($active_ws  - 1) / $max_screens))
active_monitor=$(hyprctl monitors -j | jq '.[] | select(.focused) | .id')

x=$(x_value $active_ws)
y=$(y_value $active_ws)

moveWorkspace $1 $active_monitor $x $y

# case "$1" in
# 	"left" | "move_left") x=$((($x + $matrix_size - 1) % $matrix_size));  ;;
# 	"right" | "move_right") x=$((($x + 1) % $matrix_size)) ;;
# 	"up" | "move_up") y=$((($y + $matrix_size - 1) % $matrix_size)) ;;
# 	"down" | "move_down") y=$((($y + 1) % $matrix_size)) ;;
# 	"query") echo "($x,$y)"; exit ;;
# esac

# ## Generate new workspace number
# ws=$(($max_screens * ($y * $matrix_size + $x) + $active_monitor + 1))

# case "$1" in
# 	"left" | "right" | "up" | "down") hyprctl dispatch workspace $ws ;;
# 	"move_left" | "move_right" | "move_up" | "move_down") hyprctl dispatch movetoworkspace $ws ;;
# esac

reload_waybar