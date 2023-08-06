{ pkgs, attrs, ... }:
pkgs.writeShellScriptBin "kitty" "kitty -c ~/.config/kitty/kitty.conf -c $(ls ${"${attrs.kitty-themes}/themes"} | shuf -n 1)"