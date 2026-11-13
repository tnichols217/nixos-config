{
  pkgs,
  lib,
  username,
  host-name,
  inputs,
  ...
}@args:
let
  appmod = "CTRL + ALT";

  lua = lib.generators.mkLuaInline;

  # hl.bind("MODS + KEY", dispatcher, { flags? })
  bind = keys: dispatcher: {
    _args = [
      keys
      (lua dispatcher)
    ];
  };
  bind' = keys: dispatcher: flags: {
    _args = [
      keys
      (lua dispatcher)
      flags
    ];
  };

  # hl.dsp.exec_cmd([[<cmd>]]) - lua long brackets keep shell quoting intact
  exec = cmd: "hl.dsp.exec_cmd([[${cmd}]])";

  other-host = if host-name == "ASUS" then "ROG" else "ASUS";

  nixos-update = ''sudo bash -c "cd /etc/nixos; git stash; git stash clear; git pull; nixos-rebuild switch --flake \".#${host-name}\""'';

  # Commands run once at Hyprland startup. Each entry becomes a
  # hl.exec_cmd([[<cmd>]]) line in the hyprland.start hook below.
  exec-once = {
    dunst = "${pkgs.dunst}/bin/dunst";
    hyprpaper = "${pkgs.hyprpaper}/bin/hyprpaper";
    # nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicatior";
    waybar = "${pkgs.waybar}/bin/waybar";
    hypridle = "${pkgs.hypridle}/bin/hypridle";
    blueman-tray = "${pkgs.blueman}/bin/blueman-tray";
    cliphist-text = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
    cliphist-image = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";
    ssh-keygen = ''if [ ! -f ~/.ssh/ed25519 ]; then ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f ~/.ssh/ed25519 -N "" fi'';
  };

  exec-once-hook = lib.concatStrings (
    lib.mapAttrsToList (name: cmd: "  hl.exec_cmd([[${cmd}]]) -- ${name}\n") exec-once
  );

  monitors = {
    "ASUS" = [
      {
        output = "DP-1";
        mode = "2560x1440@170";
        position = "auto";
        scale = 1;
      }
      {
        output = "DP-2";
        disabled = true;
      }
      {
        output = "DP-3";
        disabled = true;
      }
      {
        output = "DP-4";
        disabled = true;
      }
    ];
    "ROG" = [
      {
        output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. M27Q 0x01010101";
        mode = "highrr";
        position = "0x-1440";
        scale = 1;
      }
      {
        output = "desc:BOE 0x0A1D";
        mode = "2560x1600@120";
        position = "0x0";
        scale = 1;
      }
      {
        output = "desc:Dell Inc. DELL AW2518HF 99G1G77A11LU";
        mode = "1920x1080@143.98";
        position = "auto-right";
        scale = 1;
      }
      {
        output = "";
        mode = "highrr";
        position = "auto-right";
        scale = 1;
      }
      {
        output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. M27Q 23270B000407";
        mode = "highrr";
        position = "2560x-1440";
        scale = 1;
      }
      {
        output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. M27Q 23240B003867";
        mode = "highrr";
        position = "2560x-1440";
        scale = 1;
      }
    ];
    "MSI" = [ ];
    "rpi" = [
      {
        output = "";
        mode = "highres";
        position = "auto";
        scale = 1;
      }
    ];
  };
in
{
  home-manager.users.${username} = {
    xdg.configFile = {
      "hypr/hyprpaper.conf" = {
        text = import ./hyprland/hyprpaper.nix { inherit host-name; };
      };
      "hypr/hyprlock.conf" = {
        text = import ./hyprland/hyprlock.nix { inherit host-name; };
      };
      "hypr/hypridle.conf" = {
        text = import ./hyprland/hypridle.nix { inherit pkgs; };
      };
      "tofi/config" = {
        text = import ./hyprland/tofi.nix args;
      };
      "waybar/config.jsonc" = {
        text = import ./hyprland/waybar.nix args;
      };
      "waybar/style.css" = {
        source = ./hyprland/waybar/style.css;
      };
    };
    wayland.windowManager = {
      hyprland = {
        enable = true;
        # hyprland 0.57 dropped hyprlang; generate hyprland.lua instead of hyprland.conf
        configType = "lua";
        plugins = [
          # inputs.hy3.packages.x86_64-linux.hy3
        ];
        settings = {
          # hl.config({ ... })
          config = {
            general = {
              border_size = 0;
              gaps_in = 3;
              gaps_out = 0;
              gaps_workspaces = 3;
              col = {
                inactive_border = "0x33ffffff";
                active_border = "0x44ffffff";
                nogroup_border = "0x44dd7777";
                nogroup_border_active = "0x55dd7777";
              };
              layout = "dwindle";
              # layout = "hy3";
              no_focus_fallback = false;
              resize_on_border = true;
              extend_border_grab_area = 15;
              hover_icon_on_border = true;
              allow_tearing = false;
            };
            cursor = {
              inactive_timeout = 10;
              no_warps = true;
            };
            binds = {
              movefocus_cycles_fullscreen = false;
            };
            decoration = {
              rounding = 8;
              active_opacity = 1.0;
              inactive_opacity = 1.0;
              fullscreen_opacity = 1.0;
              dim_inactive = true;
              dim_strength = 0.1;
              dim_special = 0.1;
              dim_around = 0.4;
              shadow = {
                enabled = true;
                range = 5;
                render_power = 3;
                color = "0xee1a1a1a";
                color_inactive = "0xee1a1a1a";
                offset = [ 0 0 ];
                scale = 1.0;
              };
              blur = {
                enabled = true;
                size = 5;
                passes = 5;
                ignore_opacity = false;
                xray = false;
                noise = 0.0;
                contrast = 0.9;
                brightness = 0.8;
                vibrancy = 0.1;
                vibrancy_darkness = 0.0;
                special = true;
                popups = true;
                popups_ignorealpha = 0.2;
              };
            };
            animations = {
              enabled = true;
            };
            input = {
              # kb_model = "pc104";
              kb_layout = "us";
              # kb_variant = "qwerty";
              kb_options = "compose:ralt";
              numlock_by_default = false;
              repeat_rate = 25;
              repeat_delay = 500;
              sensitivity = 1.0;
              accel_profile = "flat";
              force_no_accel = false;
              left_handed = false;
              # scroll_method = "2fg";
              scroll_method = "on_button_down";
              scroll_button = 273;
              scroll_button_lock = false;
              natural_scroll = false;
              follow_mouse = 2;
              mouse_refocus = true;
              float_switch_override_focus = 1;
              special_fallthrough = false;
              touchpad = {
                disable_while_typing = true;
                natural_scroll = true;
                scroll_factor = 1.0;
                middle_button_emulation = true;
                tap_button_map = "lrm";
                clickfinger_behavior = true;
                tap_to_click = true;
                drag_lock = true;
                tap_and_drag = false;
              };
              touchdevice = {
                transform = 0;
              };
              tablet = {
                transform = 0;
                region_position = [ 0 0 ];
                region_size = [ 0 0 ];
                relative_input = false;
                output = "DP-1";
              };
            };
            # NOTE: the gestures:workspace_swipe_* options were removed in the lua
            # config. Workspace swiping was disabled before; to enable it now:
            # gesture = [ { fingers = 3; direction = "horizontal"; action = "workspace"; } ];
            group = {
              insert_after_current = true;
              focus_removed_window = true;
              col = {
                border_active = "0x44ffffff";
                border_inactive = "0x33ffffff";
                border_locked_active = "0x66ffffff";
                border_locked_inactive = "0x55ffffff";
              };
              groupbar = {
                enabled = true;
                font_family = "monospace";
                height = 14;
                col = {
                  active = "0x44ffffff";
                  inactive = "0x33ffffff";
                  locked_active = "0x66ffffff";
                  locked_inactive = "0x55ffffff";
                };
              };
            };
            misc = {
              disable_hyprland_logo = true;
              focus_on_activate = true;
            };
            debug = {
              enable_stdout_logs = true;
            };
          };
          # hl.monitor({ ... })
          monitor = monitors."${host-name}";
          # hl.env(key, value)
          env =
            [
              { _args = [ "HYPRCURSOR_THEME" "rose-pine-hyprcursor" ]; }
            ]
            ++ (
              if host-name != "ROG" then
                [
                  { _args = [ "LIBVA_DRIVER_NAME" "nvidia" ]; }
                  { _args = [ "XDG_SESSION_TYPE" "wayland" ]; }
                  { _args = [ "GBM_BACKEND" "nvidia-drm" ]; }
                  { _args = [ "__GLX_VENDOR_LIBRARY_NAME" "nvidia" ]; }
                  { _args = [ "WLR_NO_HARDWARE_CURSORS" "1" ]; }
                ]
              else
                [ ]
            );
          # hl.bind("MODS + KEY", dispatcher, { flags? })
          bind = [
            (bind "${appmod} + S" (exec "${pkgs.grimblast}/bin/grimblast copy area"))
            (bind "SUPER + SHIFT + S" (exec "${pkgs.grimblast}/bin/grimblast copy area"))
            (bind "SUPER + L" (exec "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock"))
            (bind "SUPER + SHIFT + L" "hl.dsp.exit()")
            (bind "${appmod} + F" (exec "firefox-devedition"))
            (bind "${appmod} + W" (exec "pkill .waybar-wrapped; ${pkgs.waybar}/bin/waybar"))
            (bind "${appmod} + T" (exec "${import ./shell/kitty/kitty.pkg.nix { inherit pkgs inputs; }}/bin/kitty"))
            (bind "${appmod} + D" (exec "${pkgs.kitty}/bin/kitty"))
            (bind "${appmod} + U" (exec "${pkgs.kitty}/bin/kitty --hold ${nixos-update}"))
            (bind "${appmod} + O" (exec "obsidian"))
            (bind "${appmod} + J" (exec "jellyfinmediaplayer"))
            (bind "${appmod} + E" (exec "nautilus"))
            (bind "SUPER + E" (exec "nautilus"))
            (bind "ALT + Tab" "hl.dsp.window.cycle_next()")
            (bind "ALT + SHIFT + Tab" "hl.dsp.window.cycle_next({ next = false })")
            (bind "SUPER + Tab" "hl.dsp.group.next()")
            (bind "SUPER + SHIFT + Tab" "hl.dsp.group.prev()")
            (bind "ALT + Tab" "hl.dsp.window.bring_to_top()")
            (bind "ALT + Space" (exec "${pkgs.tofi}/bin/tofi-drun --drun-launch=true"))
            (bind "SUPER + Space" (exec "${pkgs.toybox}/bin/killall -SIGUSR1 waybar"))
            (bind "SUPER + F1" (exec "sh ${./hyprland/workspace2d.sh} right"))
            (bind "SUPER + right" (exec "sh ${./hyprland/workspace2d.sh} right"))
            (bind "SUPER + CTRL + F1" (exec "sh ${./hyprland/workspace2d.sh} right all"))
            (bind "SUPER + CTRL + right" (exec "sh ${./hyprland/workspace2d.sh} right all"))
            (bind "SUPER + ALT + F1" (exec "sh ${./hyprland/workspace2d.sh} move_right"))
            (bind "SUPER + ALT + right" (exec "sh ${./hyprland/workspace2d.sh} move_right"))
            (bind "SUPER + ALT + CTRL + F1" (exec "sh ${./hyprland/workspace2d.sh} move_right all"))
            (bind "SUPER + ALT + CTRL + right" (exec "sh ${./hyprland/workspace2d.sh} move_right all"))
            (bind "SUPER + F2" (exec "sh ${./hyprland/workspace2d.sh} left"))
            (bind "SUPER + left" (exec "sh ${./hyprland/workspace2d.sh} left"))
            (bind "SUPER + CTRL + F2" (exec "sh ${./hyprland/workspace2d.sh} left all"))
            (bind "SUPER + CTRL + left" (exec "sh ${./hyprland/workspace2d.sh} left all"))
            (bind "SUPER + ALT + F2" (exec "sh ${./hyprland/workspace2d.sh} move_left"))
            (bind "SUPER + ALT + left" (exec "sh ${./hyprland/workspace2d.sh} move_left"))
            (bind "SUPER + ALT + CTRL + F2" (exec "sh ${./hyprland/workspace2d.sh} move_left all"))
            (bind "SUPER + ALT + CTRL + left" (exec "sh ${./hyprland/workspace2d.sh} move_left all"))
            (bind "SUPER + SHIFT + F1" (exec "sh ${./hyprland/workspace2d.sh} up"))
            (bind "SUPER + up" (exec "sh ${./hyprland/workspace2d.sh} up"))
            (bind "SUPER + SHIFT + CTRL + F1" (exec "sh ${./hyprland/workspace2d.sh} up all"))
            (bind "SUPER + CTRL + up" (exec "sh ${./hyprland/workspace2d.sh} up all"))
            (bind "SUPER + SHIFT + ALT + F1" (exec "sh ${./hyprland/workspace2d.sh} move_up"))
            (bind "SUPER + ALT + up" (exec "sh ${./hyprland/workspace2d.sh} move_up"))
            (bind "SUPER + SHIFT + ALT + CTRL + F1" (exec "sh ${./hyprland/workspace2d.sh} move_up all"))
            (bind "SUPER + ALT + CTRL + up" (exec "sh ${./hyprland/workspace2d.sh} move_up all"))
            (bind "SUPER + SHIFT + F2" (exec "sh ${./hyprland/workspace2d.sh} down"))
            (bind "SUPER + down" (exec "sh ${./hyprland/workspace2d.sh} down"))
            (bind "SUPER + SHIFT + CTRL + F2" (exec "sh ${./hyprland/workspace2d.sh} down all"))
            (bind "SUPER + CTRL + down" (exec "sh ${./hyprland/workspace2d.sh} down all"))
            (bind "SUPER + SHIFT + ALT + F2" (exec "sh ${./hyprland/workspace2d.sh} move_down"))
            (bind "SUPER + ALT + down" (exec "sh ${./hyprland/workspace2d.sh} move_down"))
            (bind "SUPER + SHIFT + ALT + CTRL + F2" (exec "sh ${./hyprland/workspace2d.sh} move_down all"))
            (bind "SUPER + ALT + CTRL + down" (exec "sh ${./hyprland/workspace2d.sh} move_down all"))
            (bind "SUPER + V" (exec "${pkgs.cliphist}/bin/cliphist list | ${pkgs.tofi}/bin/tofi | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"))
            (bind "SUPER + SHIFT + V" (exec ''${pkgs.openssh}/bin/ssh ${other-host} "${pkgs.cliphist}/bin/cliphist list" | ${pkgs.tofi}/bin/tofi | ${pkgs.openssh}/bin/ssh ${other-host} "${pkgs.cliphist}/bin/cliphist decode" | ${pkgs.wl-clipboard}/bin/wl-copy''))
            (bind "SUPER + CTRL + V" (exec "${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.imagemagick}/bin/display"))
            (bind "SUPER + F" "hl.dsp.window.float()")
            (bind "SUPER + G" "hl.dsp.group.toggle()")
            (bind "SUPER + SHIFT + G" "hl.dsp.window.move({ out_of_group = true })")
            (bind "ALT + F4" "hl.dsp.window.close()")
            (bind "CTRL + ALT + SHIFT + right" "hl.dsp.window.pin()")
            (bind "SUPER + bracketright" "hl.dsp.window.fullscreen({ mode = \"maximized\" })")
            (bind "XF86AudioMicMute" (exec "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
            (bind "SHIFT + XF86AudioMicMute" (exec "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
            (bind "XF86Launch1" (exec "${pkgs.kitty}/bin/kitty ${nixos-update}"))
            # lid switch (locked = works on lock screen)
            (bind' "switch:on:2a29c40" (exec ''hyprctl eval "hl.monitor({ output = \"eDP-2\", disabled = true })"'') { locked = true; })
            (bind' "switch:off:2a29c40" (exec ''hyprctl eval "hl.monitor({ output = \"eDP-2\", mode = \"2560x1600@120\", position = \"0x0\", scale = 1 })"'') { locked = true; })
            # mouse
            (bind' "SUPER + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
            (bind' "SUPER + mouse:274" "hl.dsp.window.resize()" { mouse = true; })
            # repeating
            (bind' "XF86AudioLowerVolume" (exec "${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-") { repeating = true; })
            (bind' "XF86AudioRaiseVolume" (exec "${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+") { repeating = true; })
            (bind' "XF86MonBrightnessDown" (exec ''${pkgs.brightnessctl}/bin/brightnessctl -d $(${pkgs.brightnessctl}/bin/brightnessctl -l -c backlight -m | cut -f 1 -d ",") s 1%-'') { repeating = true; })
            (bind' "XF86MonBrightnessUp" (exec ''${pkgs.brightnessctl}/bin/brightnessctl -d $(${pkgs.brightnessctl}/bin/brightnessctl -l -c backlight -m | cut -f 1 -d ",") s 1%+'') { repeating = true; })
          ];
          # hl.window_rule({ ... })
          window_rule = [
            {
              match = { class = "^(kitty)$"; };
              float = true;
            }
            {
              match = { class = "^(Display)$"; };
              float = true;
            }
            {
              match = { class = "^(Display)$"; };
              pin = true;
            }
            {
              match = { class = "^(pavucontrol)$"; };
              float = true;
            }
            {
              match = { class = ''^(org\.gnome\.nautilus)$''; };
              float = true;
            }
            {
              match = { fullscreen = true; };
              rounding = 0;
            }
          ];
          # hl.layer_rule({ ... })
          layer_rule = [
            {
              match = { namespace = "launcher"; };
              blur = true;
            }
            {
              match = { namespace = "waybar"; };
              blur = true;
            }
            {
              match = { namespace = "waybar"; };
              ignore_alpha = 0.05;
            }
          ];
          # hl.animation({ ... })
          animation = [
            {
              leaf = "workspaces";
              enabled = true;
              speed = 1;
              bezier = "default";
            }
            {
              leaf = "windows";
              enabled = true;
              speed = 1;
              bezier = "default";
            }
          ];
          # hl.on("hyprland.start", ...) - runs once at startup (old exec-once)
          # commands come from the exec-once attrset above
          on = {
            _args = [
              "hyprland.start"
              (lua "function()\n${exec-once-hook}end")
            ];
          };
        };
        xwayland.enable = true;
      };
    };
  };
}
