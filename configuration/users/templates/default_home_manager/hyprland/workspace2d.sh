#!/usr/bin/env bash

matrix_size=5
matrix_max=$(($matrix_size ** 2))
max_screens=10
direction=$1
is_all=$2
is_sync=$3

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
    local direction=$1
    local screen=$2
    local ws=$((($3 - 1) / $max_screens))
    local x=$(x_value $ws)
    local y=$(y_value $ws)
    case "$direction" in
        "left" | "right" | "move_left" | "move_right") hyprctl keyword animation "workspaces,1,1,default,slide"; ;;
        "up" | "down" | "move_up" | "move_down") hyprctl keyword animation "workspaces,1,1,default,slidevert"; ;;
    esac
    case "$direction" in
        "left" | "move_left") x=$((($x + $matrix_size - 1) % $matrix_size));  ;;
        "right" | "move_right") x=$((($x + 1) % $matrix_size)) ;;
        "up" | "move_up") y=$((($y + $matrix_size - 1) % $matrix_size)) ;;
        "down" | "move_down") y=$((($y + 1) % $matrix_size)) ;;
        "query") echo "($x,$y)"; exit ;;
    esac

    local ws=$(($max_screens * ($y * $matrix_size + $x) + $screen + 1))

    hyprctl dispatch focusmonitor $screen

    case "$direction" in
        "left" | "right" | "up" | "down") hyprctl dispatch workspace $ws ;;
        "move_left" | "move_right" | "move_up" | "move_down") hyprctl dispatch movetoworkspace $ws ;;
    esac

    hyprctl dispatch moveworkspacetomonitor $ws $screen
}

orig_mon=$(hyprctl monitors -j | jq '.[] | select(.focused) | .id, .activeWorkspace.id')
moveWorkspace $direction $(echo $orig_mon)

if [ "$is_all" = "all" ]; then
    all_ws=$(hyprctl monitors -j | jq '.[] | select(.focused | not) | .id, .activeWorkspace.id')
    direction_all=$direction
    case "$direction" in
        "move_left") direction_all="left";;
        "move_right") direction_all="right";;
        "move_up") direction_all="up";;
        "move_down") direction_all="down";;
    esac
    set -- $all_ws
    while [ ! -z "$1" ]
    do
        if [ "$is_sync" = "sync" ]; then
            moveWorkspace $direction_all $1 $(echo $orig_mon | awk '{print $2}')
        else
            moveWorkspace $direction_all $1 $2
        fi
        shift 2
    done
    moveWorkspace $direction_all $(echo $orig_mon)
fi

reload_waybar