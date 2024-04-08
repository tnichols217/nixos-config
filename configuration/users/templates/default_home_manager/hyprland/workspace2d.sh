#!/usr/bin/env bash

matrix_size=9
matrix_max=$(($matrix_size ** 2))

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

## Get active workspace and translate to x / y
active_ws=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')
active_ws=$(($active_ws % $matrix_max))
active_monitor=$(hyprctl monitors -j | jq '.[] | select(.focused) | .id')

x=$(x_value $active_ws)
y=$(y_value $active_ws)

case "$1" in
	"left" | "move_left") x=$((($x + $matrix_size - 1) % $matrix_size)) ;;
	"right" | "move_right") x=$((($x + 1) % $matrix_size)) ;;
	"up" | "move_up") y=$((($y + $matrix_size - 1) % $matrix_size)) ;;
	"down" | "move_down") y=$((($y + 1) % $matrix_size)) ;;
	"query") echo "($x,$y)"; exit ;;
esac

## Generate new workspace number
ws=$(($matrix_max * $active_monitor + ($y + 1) * $matrix_size + $x + 1))

case "$1" in
	"left" | "right" | "up" | "down") hyprctl dispatch workspace $ws ;;
	"move_left" | "move_right" | "move_up" | "move_down") hyprctl dispatch movetoworkspace $ws ;;
esac

# reload_waybar