{ pkgs, host-name, ... }:
builtins.toJSON {
  "layer" = "top";
  "position" = "top";
  "height" = 30;
  "spacing" = 4;
  "start_hidden" = true;
  "exclusive" = false;
  # "passthrough" = true;

  ############################# RIGHT
  "modules-right" = [
    "clock"
    "tray"
  ];

  "clock" = {
    # "timezone" = "America/New_York";
    "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    "format" = "{:%Y-%m-%dT%T%Ez}";
    "interval" = 1;
    "format-alt" = "{:%b %a %T}";
  };
  "tray" = {
    # "icon-size" = 21;
    "spacing" = 10;
  };

  ############################# LEFT
  "modules-left" = [
    "hyprland/workspaces"
    "group/group-info"
    "pulseaudio"
  ];

  "group/group-info" = {
    "orientation" = "inherit";
    "modules" = [
      "idle_inhibitor"
      "privacy"
      "keyboard-state"
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
  "pulseaudio" = {
    # "scroll-step" = 1; # %; can be a float
    "format" = "{volume}% {icon} {format_source}";
    "format-bluetooth" = "{volume}% {icon} {format_source}";
    "format-bluetooth-muted" = "󰝟 {icon} {format_source}";
    "format-muted" = "󰝟 {format_source}";
    "format-source" = "{volume}% ";
    "format-source-muted" = "";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "󱡏";
      "headset" = "󰋎";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = ["" "" ""];
    };
    "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
    "on-click-right" = "${pkgs.qpwgraph}/bin/qpwgraph";
    "on-scroll-up" = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+";
    "on-scroll-down" = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-";
  };
  "wireplumber" = {
    "format" = "{volume}% {icon}";
    "format-muted" = "";
    "on-click" = "helvum";
    "format-icons" = ["" "" ""];
  };
  "keyboard-state" = {
    "numlock" = true;
    "capslock" = true;
    "format" = "{name} {icon}";
    "format-icons" = {
      "locked" = "";
      "unlocked" = "";
    };
  };

  ############################# CENTER
  "modules-center" = [
    "network"
    "power-profiles-daemon"
    "group/group-monitor"
    # "group/group-power"
  ];

  "network" = {
    "format-wifi" = "{essid} ({signalStrength}%) ";
    "format-ethernet" = "{ipaddr}/{cidr} 󰈀";
    "tooltip-format" = "{ifname} via {gwaddr} ";
    "format-linked" = "{ifname} (No IP) ";
    "format-disconnected" = "Disconnected ⚠";
    "format-alt" = "{ifname} = {ipaddr}/{cidr}";
    "on-click" = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    "on-click-right" = "bash ${(pkgs.callPackage ./waybar/networking.nix {}) + "/bin/networking.sh"} connect_new";
    "on-click-middle" = "bash ${(pkgs.callPackage ./waybar/networking.nix {}) + "/bin/networking.sh"} disconnect";
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

  "group/group-monitor" = {
    "orientation" = "inherit";
    "modules" = (if host-name == "ASUS" then [] else ["battery"]) ++ [
      "backlight"
      "cpu"
      "memory"
      "temperature"
    ];
    "drawer" = {
      "transition-duration" = 500;
      "children-class" = "not-monitor";
      "transition-left-to-right" = true;
    };
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
  "backlight" = {
    "format" = "{percent}% {icon}";
    "format-icons" = ["" "" "" "" "" "" "" "" ""];
    "on-scroll-up" = "${pkgs.brightnessctl}/bin/brightnessctl -d $(${pkgs.brightnessctl}/bin/brightnessctl -l -c backlight -m | cut -f 1 -d \",\") s 1%+";
    "on-scroll-down" = "${pkgs.brightnessctl}/bin/brightnessctl -d $(${pkgs.brightnessctl}/bin/brightnessctl -l -c backlight -m | cut -f 1 -d \",\") s 1%-";
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
    "format-icons" = ["" "" ""];
  };

  "group/group-power" = {
    "orientation" = "inherit";
    "modules"= [
      "custom/power"
      "custom/reboot"
    ];
  };
  "custom/power"= {
    "format"= "";
    "tooltip"= false;
    "on-click"= "poweroff";
  };
  "custom/reboot"= {
    "format"= "󰜉";
    "tooltip"= false;
    "on-click"= "reboot";
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
}