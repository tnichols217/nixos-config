{ pkgs, attrs, ... }:
pkgs.writeShellScriptBin "kitty" "${pkgs.kitty}/bin/kitty -c ~/.config/kitty/kitty.conf -c $(ls ${"${attrs.kitty-themes}/themes"} | shuf -n 1) $argv"