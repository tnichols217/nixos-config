{ pkgs, ... }:
builtins.toJSON {
    "layer" = "top"; # Waybar at top layer
    # "position" = "bottom"; # Waybar position (top|bottom|left|right)
    "height" = 30; # Waybar height (to be removed for auto height)
    "spacing" = 4; # Gaps between modules (4px)
    "start_hidden" = true;
    "modules-right" = [
      "mpris"
      "privacy"
      "idle_inhibitor"
      "hyprland/workspaces"
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
      "clock"
      "tray"
    ];
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
      "player" = "${pkgs.playerctl}/bin/playerctl";
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
    "privacy" = {
      "icon-spacing" = 4;
      "icon-size" = 18;
      "transition-duration" = 250;
      "modules" = [
        {
          "type" = "screenshare";
          "tooltip" = true;
          "tooltip-icon-size" = 24;
        }
        {
          "type" = "audio-out";
          "tooltip" = true;
          "tooltip-icon-size" = 24;
        }
        {
          "type" = "audio-in";
          "tooltip" = true;
          "tooltip-icon-size" = 24;
        }
      ];
    };
    "hyprland/workspaces" = {
      "format" = "{name}";
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
      "interval" = 1;
      "format-alt" = "{:%b %a %T}";
    };
    "cpu" = {
      "interval" = 1;
      "format" = "{usage}% ";
      "tooltip" = false;
    };
    "memory" = {
        "format" = "{}% ";
    };
    "temperature" = {
      "interval" = 1;
      # "thermal-zone" = 2;
      # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
      "critical-threshold" = 80;
      # "format-critical" = "{temperatureC}°C {icon}";
      "format" = "{temperatureC}°C {icon}";
      "format-icons" = ["" "" ""];
    };
    "backlight" = {
      "format" = "{percent}% {icon}";
      "format-icons" = ["" "" "" "" "" "" "" "" ""];
      "on-scroll-up" = "${pkgs.brightnessctl}/bin/brightnessctl -d $(${pkgs.brightnessctl}/bin/brightnessctl -l -c backlight -m | cut -f 1 -d \",\") s 1%+";
      "on-scroll-down" = "${pkgs.brightnessctl}/bin/brightnessctl -d $(${pkgs.brightnessctl}/bin/brightnessctl -l -c backlight -m | cut -f 1 -d \",\") s 1%-";
    };
    "battery" = {
      "states" = {
        # "good" = 95;
        "warning" = 30;
        "critical" = 15;
      };
      "format" = "{capacity}% {icon}";
      "format-full" = "{capacity}% {icon}";
      "format-charging" = "{capacity}% ⚡";
      "format-plugged" = "{capacity}% ";
      "format-alt" = "{time} {icon}";
      # "format-good" = ""; # An empty format will hide the module
      # "format-full" = "";
      "format-icons" = ["" "" "" "" ""];
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
      "on-click-right" = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
      "on-scroll-up" = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+";
      "on-scroll-down" = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-";
    };
}