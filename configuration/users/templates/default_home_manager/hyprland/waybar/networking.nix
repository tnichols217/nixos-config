{ pkgs, ... }:
pkgs.writeShellScriptBin "networking.sh" ''
NMCLI_COMMAND=${pkgs.networkmanager + "/bin/nmcli"}
ROFI_COMMAND=${pkgs.tofi + "/bin/tofi"}
NOTI_COMMAND=${pkgs.libnotify + "/bin/notify-send"}
JQ_COMMAND=${pkgs.jq + "/bin/jq"}
BASE64_COMMAND=${pkgs.toybox + "/bin/base64"}
GREP_COMMAND=${pkgs.gnugrep + "/bin/grep"}
${builtins.readFile ./networking.sh}
''