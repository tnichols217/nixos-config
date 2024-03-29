{ pkgs, attrs, username, host-name, version, lib, nix-index-database, ... }@ args:
{
  home-manager.users.${username} = {
    wayland.windowManager = {
      hyprland = {
        enable = true;
        plugins = [];
        settings = {
          general = {
            border_size = 1;
            gaps_in = 5;
            gaps_out = 8;
            gaps_workspaces = 0;
            "col.inactive_border" = "0x33ffffff";
            "col.active_border" = "0x44ffffff";
            "col.nogroup_border" = "0x44dd7777";
            "col.nogroup_border_active" = "0x55dd7777";
            cursor_inactive_timeout = 10;
            layout = "dwindle";
            no_cursor_warps = false;
            no_focus_fallback = false;
            resize_on_border = true;
            extend_border_grab_area = 15;
            hover_icon_on_border = true;
            allow_tearing = false;
          };
          decoration = {
            rounding = 20;
            active_opacity = 1.0;
            inactive_opacity = 1.0;
            fullscreen_opacity = 1.0;
            drop_shadow = true;
            shadow_range = 5;
            shadow_render_power = 3;
            shadow_ignore_window = true;
            "col.shadow" = "0xee1a1a1a";
            "col.shadow_inactive" = "0xee1a1a1a";
            shadow_offset = "0 0";
            shadow_scale = 1.0;
            dim_inactive = true;
            dim_strength = 0.1;
            dim_special = 0.1;
            dim_around = 0.4;
            blur = {
              enabled = true;
              size = 10;
              passes = 3;
              ignore_opacity = false;
              xray = false;
              noise = 0.05;
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
            first_launch_animation = true;
          };
          input = {
            # kb_model = "pc104";
            kb_layout = "us";
            # kb_variant = "qwerty";
            numlock_by_default = false;
            repeat_rate = 25;
            repeat_delay = 500;
            sensitivity = 1.0;
            accel_profile = "flat";
            force_no_accel = false;
            left_handed = false;
            scroll_method = "2fg";
            scroll_button = 0;
            scroll_button_lock = true;
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
              tap-to-click = true;
              drag_lock = true;
              tap-and-drag = false;
            };
            touchdevice = {
              transform = 0;
            };
            tablet = {
              transform = 0;
              region_position = "0 0";
              region_size = "0 0";
              relative_input = true;
            };
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = 3;
            workspace_swipe_distance = 300;
            workspace_swipe_invert = true;
            workspace_swipe_min_speed_to_force = 30;
            workspace_swipe_cancel_ratio = 0.5;
            workspace_swipe_create_new = false;
            workspace_swipe_direction_lock = true;
            workspace_swipe_direction_lock_threshold = 20;
            workspace_swipe_forever = true;
            workspace_swipe_numbered = false;
          };
          group = {
            insert_after_current = true;
            focus_removed_window = true;
            "col.border_active" = "0x44ffffff";
            "col.border_inactive" = "0x33ffffff";
            "col.border_locked_active" = "0x66ffffff";
            "col.border_locked_inactive" = "0x55ffffff";
            groupbar = {
              enabled = false;
            };
          };
          misc = {
            disable_hyprland_logo = true;
          };
        };
        xwayland.enable = true;
      };
    };
  };
}
