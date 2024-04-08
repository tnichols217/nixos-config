{ pkgs, ... }:
builtins.toJSON {
    "layer" = "top"; # Waybar at top layer
    # "position" = "bottom"; # Waybar position (top|bottom|left|right)
    "height" = 30; # Waybar height (to be removed for auto height)
    # "width" = 1280; # Waybar width
    "spacing" = 4; # Gaps between modules (4px)
    # Choose the order of the modules
    "modules-left" = [
        "custom/media"
    ];
    "modules-center" = [
    ];
    "modules-right" = [
        "mpris"
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "power-profiles-daemon"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "keyboard-state"
        "sway/language"
        "battery"
        "battery#bat2"
        "clock"
        "tray"
    ];
    # Modules configuration
    # "sway/workspaces" = {
    #     "disable-scroll" = true;
    #     "all-outputs" = true;
    #     "warp-on-scroll" = false;
    #     "format" = "{name} = {icon}";
    #     "format-icons" = {
    #         "1" = "";
    #         "2" = "";
    #         "3" = "";
    #         "4" = "";
    #         "5" = "";
    #         "urgent" = "";
    #         "focused" = "";
    #         "default" = "";
    #     }
    # };
    "keyboard-state" = {
        "numlock" = true;
        "capslock" = true;
        "format" = "{name} {icon}";
        "format-icons" = {
            "locked" = "";
            "unlocked" = "";
        };
    };
    "mpd" = {
        "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
        "format-disconnected" = "Disconnected ";
        "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
        "unknown-tag" = "N/A";
        "interval" = 5;
        "consume-icons" = {
            "on" = " ";
        };
        "random-icons" = {
            "off" = "<span color=\"#f53c3c\"></span> ";
            "on" = " ";
        };
        "repeat-icons" = {
            "on" = " ";
        };
        "single-icons" = {
            "on" = "1 ";
        };
        "state-icons" = {
            "paused" = "";
            "playing" = "";
        };
        "tooltip-format" = "MPD (connected)";
        "tooltip-format-disconnected" = "MPD (disconnected)";
    };
    "mpris" = {
      "format" = "{player_icon} {dynamic}";
      "format-paused" = "{status_icon} <i>{dynamic}</i>";
      "player-icons" = {
        "default" = "▶";
        "mpv" = "🎵";
      };
      "status-icons" = {
        "paused" = "⏸";
      };
      # "ignored-players": ["firefox"]
    };
    "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
            "activated" = "";
            "deactivated" = "";
        };
    };
    "tray" = {
        # "icon-size" = 21;
        "spacing" = 10;
    };
    "clock" = {
        # "timezone" = "America/New_York";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format" = "{:%Y-%m-%dT%T%Ez}";
        "interval" = 0.5;
        "format-alt" = "{:%b %a %T}";
    };
    "cpu" = {
        "format" = "{usage}% ";
        "tooltip" = false;
    };
    "memory" = {
        "format" = "{}% ";
    };
    "temperature" = {
        # "thermal-zone" = 2;
        # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
        "critical-threshold" = 80;
        # "format-critical" = "{temperatureC}°C {icon}";
        "format" = "{temperatureC}°C {icon}";
        "format-icons" = ["" "" ""];
    };
    "backlight" = {
        # "device" = "acpi_video1";
        "format" = "{percent}% {icon}";
        "format-icons" = ["" "" "" "" "" "" "" "" ""];
    };
    "battery" = {
        "states" = {
            # "good" = 95;
            "warning" = 30;
            "critical" = 15;
        };
        "format" = "{capacity}% {icon}";
        "format-full" = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-alt" = "{time} {icon}";
        # "format-good" = ""; # An empty format will hide the module
        # "format-full" = "";
        "format-icons" = ["" "" "" "" ""];
    };
    "battery#bat2" = {
        "bat" = "BAT2";
    };
    "power-profiles-daemon" = {
      "format" = "{icon}";
      "tooltip-format" = "Power profile = {profile}\nDriver = {driver}";
      "tooltip" = true;
      "format-icons" = {
        "default" = "";
        "performance" = "";
        "balanced" = "";
        "power-saver" = "";
      };
    };
    "network" = {
        # "interface" = "wlp2*"; # (Optional) To force the use of this interface
        "format-wifi" = "{essid} ({signalStrength}%) ";
        "format-ethernet" = "{ipaddr}/{cidr} 󰈀";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname} = {ipaddr}/{cidr}";
    };
    "pulseaudio" = {
        # "scroll-step" = 1; # %; can be a float
        "format" = "{volume}% {icon} {format_source}";
        "format-bluetooth" = "{volume}% {icon} {format_source}";
        "format-bluetooth-muted" = " {icon} {format_source}";
        "format-muted" = " {format_source}";
        "format-source" = "{volume}% ";
        "format-source-muted" = "";
        "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
        };
        "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
    };
}