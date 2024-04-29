# Default Values
NMCLI_COMMAND=${NMCLI_COMMAND-nmcli}
ROFI_COMMAND=${ROFI_COMMAND-tofi}
# --width 30%
NOTI_COMMAND=${NOTI_COMMAND-notify-send}
JQ_COMMAND=${JQ_COMMAND-jq}
BASE64_COMMAND=${BASE64_COMMAND-base64}
GREP_COMMAND=${GREP_COMMAND-grep}

NOTIFICATIONS="false"

WIRELESS_INTERFACES=($($NMCLI_COMMAND device | awk '$2=="wifi" {print $1}'))
SELECTED_INTERFACE=${WIRELESS_INTERFACES[0]}

WIFI_LIST=""
SELECTED_WIFI=""

VPN_LIST=""
SELECTED_VPN=""

function notification() {
	[[ "$NOTIFICATIONS" == "true" ]] && $NOTI_COMMAND $1 "$2"
}

function select_interface() {
	SELECTED_INTERFACE=$($NMCLI_COMMAND -t -f DEVICE,TYPE d | $JQ_COMMAND -sRr 'split("\n") | map(split(":") | {"device":.[0], "type":.[1]} | select(.type=="wifi") | .device) | join("\n")' | $ROFI_COMMAND)
}

function wireless_interface_state() {
	ACTIVE_SSID=$($NMCLI_COMMAND -g GENERAL.CONNECTION device show $SELECTED_INTERFACE)
}

function scan() {
	notification "Wifi" "Scanning"
	WIFI_LIST=$($NMCLI_COMMAND -t -f SSID,SECURITY,SIGNAL device wifi list ifname "$SELECTED_INTERFACE" --rescan yes | $JQ_COMMAND -sRr 'split("\n") | map(split(":") | select(.[0] | length > 0) | select(.[0] != "--")) | unique_by(.[0]) | map((.[0] + " " * 33)[:33] + "    " + (.[1] + " " * 12)[:12] + "    " + .[2]) | join("\n")' | $BASE64_COMMAND)
}

function get_wifi() {
	WIFI_LIST=$($NMCLI_COMMAND -t -f SSID,SECURITY,SIGNAL device wifi list ifname "$SELECTED_INTERFACE" --rescan no | $JQ_COMMAND -sRr 'split("\n") | map(split(":") | select(.[0] | length > 0) | select(.[0] != "--")) | unique_by(.[0]) | map((.[0] + " " * 33)[:33] + "    " + (.[1] + " " * 12)[:12] + "    " + .[2]) | join("\n")' | $BASE64_COMMAND)
}

function select_wifi() {
	get_wifi
	SELECTED_WIFI=$(echo "$WIFI_LIST" | $BASE64_COMMAND --decode | $ROFI_COMMAND --width 30% --require-match false --prompt-text "SSID" | $JQ_COMMAND -sRr '.[:32] | gsub("^\\s+|\\s+$";"")')
}

function change_wifi_state() {
	notification "Wifi" "Turning $1"
	$NMCLI_COMMAND radio wifi "$1"
}

function net_restart() {
	notification "Wifi" "Restarting"
	$NMCLI_COMMAND networking off && sleep 3 && $NMCLI_COMMAND networking on
}

function disconnect() {
	wireless_interface_state
	notification Wifi "Disconnecting from $ACTIVE_SSID"
	$NMCLI_COMMAND con down id "$ACTIVE_SSID"
}

function connect() {
	notification "Wifi" "Connecting to $1"
	local pswd=("" "")
	local hidden=("" "")
	if [[ -v 2 ]] && [[ $2 != "" ]]; then
		pswd=("password" "$2")
	fi
	if [[ $(echo "$WIFI_LIST" | $BASE64_COMMAND --decode | $JQ_COMMAND -sR "split(\"\n\") | map(.[:32] | gsub(\"^\\\\s+|\\\\s+$\";\"\") | select(. != \"\") | select(. == \"$1\")) | length > 0" ) == "false" ]]; then
		hidden=("hidden" "yes")
	fi
	{ [[ $($NMCLI_COMMAND dev wifi con "$1" ${pswd[0]} ${pswd[1]} ifname "$SELECTED_INTERFACE" ${hidden[0]} ${hidden[1]} | $GREP_COMMAND -c "successfully activated") -eq "1" ]] && notification "Wifi" "Connected to '$1'"; } || notification "Wifi" "Connection Failed"
}

function enter_password() {
	PASS=$(echo "" | $ROFI_COMMAND --prompt-text "Password" --require-match false)
}

function connect_new() {
	get_wifi
	select_wifi
    enter_password

	connect "$SELECTED_WIFI" "$PASS"
}

function get_vpns() {
	VPN_LIST=$($NMCLI_COMMAND -t -f NAME,TYPE,ACTIVE con show | $JQ_COMMAND -sRr 'split("\n") | map(split(":") | select(.[1] == "vpn", .[1] == "wireguard") | (if .[2] == "yes" then "+ " else "  " end) + (.[0] + " " * 33)[:33] + "    " + .[1]) | join("\n")')
}

function select_vpn() {
	get_vpns
	SELECTED_VPN=$(echo "$VPN_LIST" | $ROFI_COMMAND --prompt-text "VPN" --width 40%)
	echo $SELECTED_VPN
}

function toggle_vpn() {
	local action=$(echo "$SELECTED_VPN" | $JQ_COMMAND -sRr '.[0:1] == "+"')
	if [[ $action == "true" ]]; then
		action="down"
	else
        action="up"
	fi
	$NMCLI_COMMAND c $action $(echo "$SELECTED_VPN" | $JQ_COMMAND -sRr '.[2:35] | gsub("^\\s+|\\s+$";"")')
}

function change_vpn_state() {
	select_vpn
	toggle_vpn
}

if [[ $1 == "" ]] || [[ $1 == "--help" ]]; then
	echo "Usage: $0 [operation] [operation] ..."
	echo "Valid options:"
	echo "  select_interface"
	echo "  scan"
	echo "  select_wifi"
	echo "  change_wifi_state"
	echo "  net_restart"
	echo "  disconnect"
	echo "  connect_new"
	echo "  select_vpn"
	echo "  toggle_vpn"
	echo "  change_vpn_state"
	echo "Operations are called in order that they are in the arguments to this script"
	exit
fi

while [ ! -z "$1" ]
do
    $1
	shift 1
done
