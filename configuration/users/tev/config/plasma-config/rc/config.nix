{ pkgs, host-name, addresses }:
let
background = (import ./config/background.nix { inherit host-name; });
in
{
  "/plasma-localerc" = {
    "Formats" = {
      "items" = {
        "LANG" = "en_SG.UTF-8";
        "LC_ALL" = "en_SG.UTF-8";
        "LC_TIME" = "en_SG.UTF-8";
        "LC_NUMERIC" = "en_SG.UTF-8";
        "LC_MONETARY" = "en_SG.UTF-8";
        "LC_MEASUREMENT" = "en_SG.UTF-8";
      };
    };
  };
  "/kglobalshortcutsrc" = {
    "kcm_touchpad" = {
      "items" = {
        "Disable Touchpad" = "Touchpad Off,Touchpad Off,Disable Touchpad";
        "Enable Touchpad" = "Touchpad On,Touchpad On,Enable Touchpad";
        "Toggle Touchpad" = "Touchpad Toggle,Touchpad Toggle,Toggle Touchpad";
        "_k_friendly_name" = "Touchpad";
      };
    };
    "kded5" = {
      "items" = {
        "Show System Activity" = "Ctrl+Esc,Ctrl+Esc,Show System Activity";
        "_k_friendly_name" = "KDE Daemon";
        "display" = "Display\tMeta+P,Display\tMeta+P,Switch Display";
      };
    };
    "khotkeys" = {
      "items" = {
        "_k_friendly_name" = "Custom Shortcuts Service";
        "{2b622f4b-e7dd-4cb3-a362-b4bb59688264}" = "Meta+Shift+S,none,Flameshot Gui";
      };
    };
    "kmix" = {
      "items" = {
        "_k_friendly_name" = "Audio Volume";
        "decrease_microphone_volume" = "Microphone Volume Down,Microphone Volume Down,Decrease Microphone Volume";
        "decrease_volume" = "Volume Down,Volume Down,Decrease Volume";
        "increase_microphone_volume" = "Microphone Volume Up,Microphone Volume Up,Increase Microphone Volume";
        "increase_volume" = "Volume Up,Volume Up,Increase Volume";
        "mic_mute" = "Microphone Mute\tMeta+Volume Mute,Microphone Mute\tMeta+Volume Mute,Mute Microphone";
        "mute" = "Volume Mute,Volume Mute,Mute";
      };
    };
    "ksmserver" = {
      "items" = {
        "Halt Without Confirmation" = "none,,Halt Without Confirmation";
        "Lock Session" = "Meta+L\tCtrl+Alt+L\tScreensaver,Meta+L\tCtrl+Alt+L\tScreensaver,Lock Session";
        "Log Out" = "Ctrl+Alt+Del,Ctrl+Alt+Del,Log Out";
        "Log Out Without Confirmation" = "none,,Log Out Without Confirmation";
        "Reboot Without Confirmation" = "none,,Reboot Without Confirmation";
        "_k_friendly_name" = "Session Management";
      };
    };
    "kwin" = {
      "items" = {
        "Expose" = "Meta+Tab\tCtrl+F9,Ctrl+F9,Toggle Present Windows (Current desktop)";
        "ExposeAll" = "Meta+Shift+Tab\tLaunch (C)\tCtrl+F10,Ctrl+F10\tLaunch (C),Toggle Present Windows (All desktops)";
        "ExposeClass" = "Ctrl+F7,Ctrl+F7,Toggle Present Windows (Window class)";
        "Kill Window" = "Ctrl+Alt+Esc,Ctrl+Alt+Esc,Kill Window";
        "Show Desktop" = "Meta+D,Meta+D,Show Desktop";
        "ShowDesktopGrid" = "Ctrl+F8,Ctrl+F8,Show Desktop Grid";
        "Suspend Compositing" = "Alt+Shift+F12,Alt+Shift+F12,Suspend Compositing";
        "Switch One Desktop Down" = "Meta+Ctrl+@\tMeta+Down,Meta+Ctrl+Down,Switch One Desktop Down";
        "Switch One Desktop Up" = "Meta+Up\tMeta+Ctrl+!,Meta+Ctrl+Up,Switch One Desktop Up";
        "Switch One Desktop to the Left" = "Meta+Left\tMeta+Ctrl+2,Meta+Ctrl+Left,Switch One Desktop to the Left";
        "Switch One Desktop to the Right" = "Meta+Right\tMeta+Ctrl+1,Meta+Ctrl+Right,Switch One Desktop to the Right";
        "Switch Window Down" = "none,Meta+Alt+Down,Switch to Window Below";
        "Switch Window Left" = "none,Meta+Alt+Left,Switch to Window to the Left";
        "Switch Window Right" = "none,Meta+Alt+Right,Switch to Window to the Right";
        "Switch Window Up" = "none,Meta+Alt+Up,Switch to Window Above";
        "Walk Through Windows" = "Alt+Tab,Alt+Tab,Walk Through Windows";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Backtab,Alt+Shift+Backtab,Walk Through Windows (Reverse)";
        "Walk Through Windows of Current Application" = "Alt+`,Alt+`,Walk Through Windows of Current Application";
        "Walk Through Windows of Current Application (Reverse)" = "Alt+~,Alt+~,Walk Through Windows of Current Application (Reverse)";
        "Window Above Other Windows" = "Ctrl+Alt+Shift+Up,,Keep Window Above Others";
        "Window Below Other Windows" = "Ctrl+Alt+Shift+Down,,Keep Window Below Others";
        "Window Close" = "Alt+F4,Alt+F4,Close Window";
        "Window Maximize" = "Meta+PgUp\tMeta+],Meta+PgUp,Maximize Window";
        "Window Minimize" = "Meta+PgDown\tMeta+[,Meta+PgDown,Minimize Window";
        "Window On All Desktops" = "Ctrl+Alt+Shift+Right,,Keep Window on All Desktops";
        "Window One Desktop Down" = "Meta+Ctrl+Shift+Down\tMeta+Ctrl+Down\tMeta+Ctrl+Alt+@,Meta+Ctrl+Shift+Down,Window One Desktop Down";
        "Window One Desktop Up" = "Meta+Ctrl+Shift+Up\tMeta+Ctrl+Up\tMeta+Ctrl+Alt+!,Meta+Ctrl+Shift+Up,Window One Desktop Up";
        "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left\tMeta+Ctrl+Alt+2\tMeta+Ctrl+Left,Meta+Ctrl+Shift+Left,Window One Desktop to the Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right\tMeta+Ctrl+Right\tMeta+Ctrl+Alt+1,Meta+Ctrl+Shift+Right,Window One Desktop to the Right";
        "Window Operations Menu" = "Alt+F3,Alt+F3,Window Operations Menu";
        "Window Quick Tile Bottom" = "Meta+Alt+Down,Meta+Down,Quick Tile Window to the Bottom";
        "Window Quick Tile Left" = "Meta+Alt+Left,Meta+Left,Quick Tile Window to the Left";
        "Window Quick Tile Right" = "Meta+Alt+Right,Meta+Right,Quick Tile Window to the Right";
        "Window Quick Tile Top" = "Meta+Alt+Up,Meta+Up,Quick Tile Window to the Top";
        "Window to Next Screen" = "Meta+Shift+Right,Meta+Shift+Right,Window to Next Screen";
        "Window to Previous Screen" = "Meta+Shift+Left,Meta+Shift+Left,Window to Previous Screen";
        "_k_friendly_name" = "KWin";
        "view_actual_size" = "Meta+0,Meta+0,Actual Size";
        "view_zoom_in" = "Meta+=,Meta+=,Zoom Out";
        "view_zoom_out" = "Meta+-,Meta+-,Zoom Out";
      };
    };
    "mediacontrol" = {
      "items" = {
        "_k_friendly_name" = "Media Controller";
        "mediavolumedown" = "none,,Media volume down";
        "mediavolumeup" = "none,,Media volume up";
        "nextmedia" = "Alt+Media Play\tMedia Next,Media Next,Media playback next";
        "pausemedia" = "Media Pause,Media Pause,Pause media playback";
        "playmedia" = "none,,Play media playback";
        "playpausemedia" = "Media Play,Media Play,Play/Pause media playback";
        "previousmedia" = "Ctrl+Media Play\tMedia Previous,Media Previous,Media playback previous";
        "stopmedia" = "Media Stop,Media Stop,Stop media playback";
      };
    };
    "org.kde.dolphin.desktop" = {
      "items" = {
        "_k_friendly_name" = "Dolphin";
        "_launch" = "Meta+E,Meta+E,Dolphin";
      };
    };
    "kitty.desktop" = {
      "items" = {
        "_k_friendly_name" = "Kitty";
        "_launch" = "Ctrl+Alt+T,none,Kitty";
      };
    };
    "org.kde.krunner.desktop" = {
      "items" = {
        "RunClipboard" = "Alt+Shift+F2,Alt+Shift+F2,Run command on clipboard contents";
        "_k_friendly_name" = "KRunner";
        "_launch" = "Alt+Space\tAlt+F2\tSearch,Alt+Space\tAlt+F2\tSearch,KRunner";
      };
    };
    "org.kde.plasma.emojier.desktop" = {
      "items" = {
        "_k_friendly_name" = "Emoji Selector";
        "_launch" = "Meta+.,Meta+.,Emoji Selector";
      };
    };
    "org_kde_powerdevil" = {
      "items" = {
        "Decrease Keyboard Brightness" = "Keyboard Brightness Down,Keyboard Brightness Down,Decrease Keyboard Brightness";
        "Decrease Screen Brightness" = "Monitor Brightness Down,Monitor Brightness Down,Decrease Screen Brightness";
        "Hibernate" = "Hibernate,Hibernate,Hibernate";
        "Increase Keyboard Brightness" = "Keyboard Brightness Up,Keyboard Brightness Up,Increase Keyboard Brightness";
        "Increase Screen Brightness" = "Monitor Brightness Up,Monitor Brightness Up,Increase Screen Brightness";
        "PowerDown" = "Power Down,Power Down,Power Down";
        "PowerOff" = "Power Off,Power Off,Power Off";
        "Sleep" = "Sleep,Sleep,Suspend";
        "Toggle Keyboard Backlight" = "Keyboard Light On/Off,Keyboard Light On/Off,Toggle Keyboard Backlight";
        "_k_friendly_name" = "Power Management";
      };
    };
    "plasmashell" = {
      "items" = {
        "_k_friendly_name" = "Plasma";
        "activate task manager entry 1" = "Meta+1,Meta+1,Activate Task Manager Entry 1";
        "activate task manager entry 10" = "none,Meta+0,Activate Task Manager Entry 10";
        "activate task manager entry 2" = "Meta+2,Meta+2,Activate Task Manager Entry 2";
        "activate task manager entry 3" = "Meta+3,Meta+3,Activate Task Manager Entry 3";
        "activate task manager entry 4" = "Meta+4,Meta+4,Activate Task Manager Entry 4";
        "activate task manager entry 5" = "Meta+5,Meta+5,Activate Task Manager Entry 5";
        "activate task manager entry 6" = "Meta+6,Meta+6,Activate Task Manager Entry 6";
        "activate task manager entry 7" = "Meta+7,Meta+7,Activate Task Manager Entry 7";
        "activate task manager entry 8" = "Meta+8,Meta+8,Activate Task Manager Entry 8";
        "activate task manager entry 9" = "Meta+9,Meta+9,Activate Task Manager Entry 9";
        "show dashboard" = "Ctrl+F12,Ctrl+F12,Show Desktop";
        "show-on-mouse-pos" = "Meta+V,Meta+V,Open Klipper at Mouse Position";
      };
    };
    "systemsettings.desktop" = {
      "items" = {
        "_k_friendly_name" = "System Settings";
        "_launch" = "Tools,Tools,System Settings";
      };
    };
  };
  "/kwinrc" = {
    "Compositing" = {
      "items" = {
        "GLCore" = "true";
        "OpenGLIsUnsafe" = "false";
      };
    };
    "Desktops" = {
      "items" = {
        "Id_1" = "5d9883a3-5318-4c83-85db-70712ba16bb2";
        "Id_10" = "9b0afee8-b349-4ad5-ae58-2188950efe1c";
        "Id_11" = "6e72eacc-55c6-4792-b5c9-f5ed1a212afe";
        "Id_12" = "031fdbd2-af14-4565-9aca-27262b5a29ec";
        "Id_13" = "28a903a9-7aa6-4fa8-ab1d-0979d8d65d0e";
        "Id_14" = "6cd1f5e0-5e1b-4f62-817f-1d84dcf54170";
        "Id_15" = "47db55cd-de5c-4cf8-80a9-fd402b8a0f0a";
        "Id_16" = "cd51710b-9d9b-4c4c-8ec6-ba7121a53b40";
        "Id_17" = "88e28943-bdcb-44c9-83e9-9dc03154ef9b";
        "Id_18" = "38a8fb28-c744-43d0-9c90-2f97c5bed6f6";
        "Id_19" = "972d14b5-2582-4c50-bb8b-c5fb2b2d2959";
        "Id_2" = "3253195e-4655-451c-8cd3-b5e7a3b5a6eb";
        "Id_20" = "fcd2e084-8cd8-443e-9a9e-6e5a87404d7b";
        "Id_3" = "d50e4bf7-8290-4dfa-88e4-c1f3d225ab09";
        "Id_4" = "bcb3771d-be99-45e4-959b-4288a0004acf";
        "Id_5" = "548cdecb-03f4-4bf0-8094-7cdabbfc748b";
        "Id_6" = "22e8b3c8-ccce-4685-a137-036bc71ee230";
        "Id_7" = "1d6d6a15-8237-4a9d-8298-47acfc0fe056";
        "Id_8" = "03edf17b-a4b4-4979-8d5a-ab5fe0fac7c3";
        "Id_9" = "43e8a1f9-6936-40e7-8651-20840064f61a";
        "Name_10" = "10";
        "Name_11" = "11";
        "Name_12" = "12";
        "Name_13" = "13";
        "Name_14" = "14";
        "Name_15" = "15";
        "Name_16" = "16";
        "Name_17" = "17";
        "Name_18" = "18";
        "Name_19" = "19";
        "Name_2" = "2";
        "Name_20" = "20";
        "Name_3" = "3";
        "Name_4" = "4";
        "Name_5" = "5";
        "Name_6" = "6";
        "Name_7" = "7";
        "Name_8" = "8";
        "Name_9" = "9";
        "Number" = "20";
        "Rows" = "4";
      };
    };
    "Effect-blur" = {
      "items" = {
        "BlurStrength" = "3";
        "NoiseStrength" = "0";
      };
    };
    "Effect-presentWindows" = {
      "items" = {
        "BorderActivateAll" = "9";
      };
    };
    "Effect-slide" = {
      "items" = {
        "SlideDocks" = "true";
        "HorizontalGap" = "0";
        "VerticalGap" = "0";
      };
    };
    "Effect-wobbly" = {
      "items" = {
        "AdvancedMode" = "true";
        "Drag" = "85";
        "Stiffness" = "10";
        "WobblynessLevel" = "1";
      };
    };
    "KDE" = {
      "items" = {
        "AnimationDurationFactor" = "0.25";
      };
    };
    "MouseBindings" = {
      "items" = {
        "CommandAll2" = "Resize";
      };
    };
    "Plugins" = {
      "items" = {
        "blurEnabled" = "true";
        "contrastEnabled" = "false";
        "kwin4_effect_dimscreenEnabled" = "true";
        "kwin4_effect_translucencyEnabled" = "true";
        "screenedgeEnabled" = "false";
        "wobblywindowsEnabled" = "true";
      };
    };
    "Script-desktopchangeosd" = {
      "items" = {
        "PopupHideDelay" = "200";
      };
    };
    "TabBox" = {
      "items" = {
        "DesktopLayout" = "org.kde.breeze.desktop";
        "DesktopListLayout" = "org.kde.breeze.desktop";
        "BorderActivate" = "9";
        "LayoutName" = "thumbnail_grid";
        "MultiScreenMode" = "1";
      };
    };
    "Windows" = {
      "items" = {
        "Placement" = "Centered";
        "ElectricBorderCooldown" = "150";
        "ElectricBorderDelay" = "100";
        "RollOverDesktops" = "true";
        "SeparateScreenFocus" = "true";
      };
    };
    "org.kde.kdecoration2" = {
      "items" = {
        "BorderSize" = "None";
        "BorderSizeAuto" = "false";
        "library" = "org.kde.breeze";
        "theme" = "__aurorae__svg__Sweet-Dark-transparent";
      };
    };
  };
  "/kxkbrc" = {
    "Layout" = {
      "items" = {
        "DisplayNames" = ",";
        "LayoutList" = "us,us";
        "Options" = "terminate:ctrl_alt_bksp,compose:ralt,grp:win_space_toggle";
        "ResetOldOptions" = "true";
        "Use" = "true";
        "VariantList" = ",dvorak";
      };
    };
  };
  "/powermanagementprofilesrc" = {
    "AC" = {
      "items" = {
        "icon" = "battery-charging";
      };
      "groups" = {
        "DPMSControl" = {
          "items" = {
            "idleTime" = "600";
            "lockBeforeTurnOff" = "0";
          };
        };
        "DimDisplay" = {
          "items" = {
            "idleTime" = "300000";
          };
        };
        "HandleButtonEvents" = {
          "items" = {
            "lidAction" = "1";
            "powerButtonAction" = "16";
            "powerDownAction" = "16";
          };
        };
      };
    };
    "Battery" = {
      "items" = {
        "icon" = "battery-060";
      };
      "groups" = {
        "DPMSControl" = {
          "items" = {
            "idleTime" = "300";
            "lockBeforeTurnOff" = "0";
          };
        };
        "DimDisplay" = {
          "items" = {
            "idleTime" = "120000";
          };
        };
        "HandleButtonEvents" = {
          "items" = {
            "lidAction" = "1";
            "powerButtonAction" = "16";
            "powerDownAction" = "16";
          };
        };
        "SuspendSession" = {
          "items" = {
            "idleTime" = "600000";
            "suspendType" = "1";
          };
        };
      };
    };
    "LowBattery" = {
      "items" = {
        "icon" = "battery-low";
      };
      "groups" = {
        "BrightnessControl" = {
          "items" = {
            "value" = "30";
          };
        };
        "DPMSControl" = {
          "items" = {
            "idleTime" = "120";
            "lockBeforeTurnOff" = "0";
          };
        };
        "DimDisplay" = {
          "items" = {
            "idleTime" = "60000";
          };
        };
        "HandleButtonEvents" = {
          "items" = {
            "lidAction" = "1";
            "powerButtonAction" = "16";
            "powerDownAction" = "16";
          };
        };
        "SuspendSession" = {
          "items" = {
            "idleTime" = "300000";
            "suspendType" = "1";
          };
        };
      };
    };
  };
  "/plasmarc" = {
    "Theme" = {
      "items" = {
        "name" = "Arch";
      };
    };
    "Theme-plasmathemeexplorer" = {
      "items" = {
        "name" = "Arch";
      };
    };
    "Wallpapers" = {
      "items" = {
        "usersWallpapers" = "${background}";
      };
    };
  };
  "/katerc" = {
    "General" = {
      "items" = {
        "Config Revision" = "10";
        "Days Meta Infos" = "30";
        "Save Meta Infos" = "true";
        "Show Full Path in Title" = "false";
        "Show Menu Bar" = "true";
        "Show Status Bar" = "true";
        "Show Tab Bar" = "true";
        "Show Url Nav Bar" = "true";
      };
    };
    "KTextEditor Document" = {
      "items" = {
        "Allow End of Line Detection" = "true";
        "Auto Detect Indent" = "true";
        "Auto Save" = "true";
        "Auto Save Interval" = "0";
        "Auto Save On Focus Out" = "true";
        "BOM" = "false";
        "Backup Local" = "false";
        "Backup Prefix" = "";
        "Backup Remote" = "false";
        "Backup Suffix" = "~";
        "Camel Cursor" = "true";
        "Encoding" = "UTF-8";
        "End of Line" = "0";
        "Indent On Backspace" = "true";
        "Indent On Tab" = "true";
        "Indent On Text Paste" = "false";
        "Indentation Mode" = "normal";
        "Indentation Width" = "4";
        "Keep Extra Spaces" = "false";
        "Line Length Limit" = "10000";
        "Newline at End of File" = "true";
        "On-The-Fly Spellcheck" = "false";
        "Overwrite Mode" = "false";
        "PageUp/PageDown Moves Cursor" = "false";
        "Remove Spaces" = "1";
        "ReplaceTabsDyn" = "true";
        "Show Spaces" = "0";
        "Show Tabs" = "true";
        "Smart Home" = "true";
        "Swap Directory" = "";
        "Swap File Mode" = "1";
        "Swap Sync Interval" = "15";
        "Tab Handling" = "2";
        "Tab Width" = "4";
        "Trailing Marker Size" = "1";
        "Word Wrap" = "false";
        "Word Wrap Column" = "80";
      };
    };
    "KTextEditor Editor" = {
      "items" = {
        "Encoding Prober Type" = "1";
        "Fallback Encoding" = "ISO 8859-15";
      };
    };
    "KTextEditor Renderer" = {
      "items" = {
        "Animate Bracket Matching" = "true";
        "Auto Color Theme Selection" = "true";
        "Line Height Multiplier" = "1";
        "Show Indentation Lines" = "false";
        "Show Whole Bracket Expression" = "false";
        "Word Wrap Marker" = "false";
      };
    };
    "KTextEditor View" = {
      "items" = {
        "Allow Mark Menu" = "true";
        "Auto Brackets" = "false";
        "Auto Center Lines" = "0";
        "Auto Completion" = "true";
        "Auto Completion Preselect First Entry" = "true";
        "Backspace Remove Composed Characters" = "false";
        "Bookmark Menu Sorting" = "0";
        "Bracket Match Preview" = "false";
        "Chars To Enclose Selection" = "<>(){}[]'\"";
        "Default Mark Type" = "1";
        "Dynamic Word Wrap" = "true";
        "Dynamic Word Wrap Align Indent" = "80";
        "Dynamic Word Wrap At Static Marker" = "false";
        "Dynamic Word Wrap Indicators" = "1";
        "Dynamic Wrap not at word boundaries" = "false";
        "Fold First Line" = "false";
        "Folding Bar" = "true";
        "Folding Preview" = "true";
        "Icon Bar" = "false";
        "Input Mode" = "0";
        "Keyword Completion" = "true";
        "Line Modification" = "true";
        "Line Numbers" = "true";
        "Maximum Search History Size" = "100";
        "Mouse Paste At Cursor Position" = "false";
        "Multiple Cursor Modifier" = "134217728";
        "Persistent Selection" = "false";
        "Scroll Bar Marks" = "false";
        "Scroll Bar Mini Map All" = "true";
        "Scroll Bar Mini Map Width" = "60";
        "Scroll Bar MiniMap" = "true";
        "Scroll Bar Preview" = "true";
        "Scroll Past End" = "false";
        "Search/Replace Flags" = "140";
        "Show Documentation With Completion" = "true";
        "Show Focus Frame Around Editor" = "true";
        "Show Folding Icons On Hover Only" = "true";
        "Show Line Count" = "false";
        "Show Scrollbars" = "0";
        "Show Word Count" = "false";
        "Smart Copy Cut" = "true";
        "Text Drag And Drop" = "true";
        "User Sets Of Chars To Enclose Selection" = "";
        "Vi Input Mode Steal Keys" = "false";
        "Vi Relative Line Numbers" = "false";
        "Word Completion" = "true";
        "Word Completion Minimal Word Length" = "3";
        "Word Completion Remove Tail" = "true";
      };
    };
    "UiSettings" = {
      "items" = {
        "ColorScheme" = "Default";
      };
    };
    "filetree" = {
      "items" = {
        "editShade" = "5,88,104";
        "listMode" = "false";
        "shadingEnabled" = "true";
        "showCloseButton" = "false";
        "showFullPathOnRoots" = "false";
        "showToolbar" = "true";
        "sortRole" = "0";
        "viewShade" = "58,83,115";
      };
    };
  };
  "/filetypesrc" = {
    "EmbedSettings" = {
      "items" = {
        "embed-application/octet-stream" = "false";
        "embed-application/x-wine-extension-ini" = "false";
      };
    };
  };
  "/kcmshell5rc" = {
    "UiSettings" = {
      "items" = {
        "ColorScheme" = "Default";
      };
    };
  };
  "/kiorc" = {
    "Confirmations" = {
      "items" = {
        "ConfirmDelete" = "false";
        "ConfirmEmptyTrash" = "false";
      };
    };
    "Executable scripts" = {
      "items" = {
        "behaviourOnLaunch" = "execute";
      };
    };
  };
  "/konsolerc" = {
    "Desktop Entry" = {
      "items" = {
        "DefaultProfile" = "KonsoleTheme.profile";
      };
    };
    "UiSettings" = {
      "items" = {
        "ColorScheme" = "";
        "WindowColorScheme" = "Default";
      };
    };
    "MainWindow" = {
      "items" = {
        "MenuBar" = "Disabled";
        "StatusBar" = "Disabled";
        "ToolBarsMovable" = "Disabled";
        # konsole wont hide toolbars without a state?
        "State" = "AAAA/wAAAAD9AAAAAQAAAAAAAAAAAAAAAPwCAAAAAvsAAAAiAFEAdQBpAGMAawBDAG8AbQBtAGEAbgBkAHMARABvAGMAawAAAAAA/////wAAAK0BAAAD+wAAABwAUwBTAEgATQBhAG4AYQBnAGUAcgBEAG8AYwBrAAAAAAD/////AAAA0wEAAAMAAADiAAAAZAAAAAQAAAAEAAAACAAAAAj8AAAAAQAAAAIAAAACAAAAFgBtAGEAaQBuAFQAbwBvAGwAQgBhAHIAAAAAAP////8AAAAAAAAAAAAAABwAcwBlAHMAcwBpAG8AbgBUAG8AbwBsAGIAYQByAAAAAAD/////AAAAAAAAAAA=";
      };
    };
    "SplitView" = {
      "items" = {
        "SplitViewVisibility" = "AlwaysHideSplitHeader";
      };
    };
    "TabBar" = {
      "items" = {
        "CloseTabButton" = "None";
        "CloseTabOnMiddleMouseButton" = "true";
        "TabBarPosition" = "Top";
      };
    };
  };
  "/touchpadxlibinputrc" = {
    "SynPS/2 Synaptics TouchPad" = {
      "items" = {
        "naturalScroll" = "true";
        "pointerAccelerationProfileAdaptive" = "false";
        "pointerAccelerationProfileFlat" = "true";
        "tapDragLock" = "true";
        "tapToClick" = "true";
      };
    };
    "ASUE120A:00 04F3:319B Touchpad" = {
      "items" = {
        "naturalScroll" = "true";
        "pointerAccelerationProfileAdaptive" = "false";
        "pointerAccelerationProfileFlat" = "true";
        "tapDragLock" = "true";
        "tapToClick" = "true";
      };
    };
  };
  "/baloofilerc" = {
    "Basic Settings" = {
      "items" = {
        "Indexing-Enabled" = "false";
      };
    };
    "General" = {
      "items" = {
        "dbVersion" = "2";
        "exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,core-dumps,lost+found";
        "exclude filters version" = "8";
      };
    };
  };
  "/kscreenlockerrc" = {
    "Greeter" = {
      "items" = {
        "Theme" = "Arch";
      };
      "groups" = {
        "Wallpaper" = {
          "groups" = {
            "org.kde.image" = {
              "groups" = {
                "General" = {
                  "items" = {
                    "Image" = "${background}";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  "/ksplashrc" = {
    "KSplash" = {
      "items" = {
        "Engine" = "KSplashQML";
        "Theme" = "Arch";
      };
    };
  };
  "/systemmonitorrc" = {
    "TaskDialog" = {
      "items" = {
        "normalizeCPUUsage" = "true";
        "showCommandLineOptions" = "false";
        "showTooltips" = "true";
        "showTotals" = "true";
        "units" = "1";
        "updateIntervalMSecs" = "1000";
      };
    };
  };
  "/khotkeysrc" = {
    "Data" = {
      "items" = {
        "DataCount" = "2";
      };
    };
    "Data_1" = {
      "items" = {
        "Comment" = "Comment";
        "DataCount" = "1";
        "Enabled" = "true";
        "Name" = "flameshot";
        "SystemGroup" = "0";
        "Type" = "ACTION_DATA_GROUP";
      };
    };
    "Data_1Conditions" = {
      "items" = {
        "Comment" = "";
        "ConditionsCount" = "0";
      };
    };
    "Data_1_1" = {
      "items" = {
        "Comment" = "Comment";
        "Enabled" = "true";
        "Name" = "Flameshot Gui";
        "Type" = "SIMPLE_ACTION_DATA";
      };
    };
    "Data_1_1Actions" = {
      "items" = {
        "ActionsCount" = "1";
      };
    };
    "Data_1_1Actions0" = {
      "items" = {
        "CommandURL" = "flameshot gui";
        "Type" = "COMMAND_URL";
      };
    };
    "Data_1_1Conditions" = {
      "items" = {
        "Comment" = "";
        "ConditionsCount" = "0";
      };
    };
    "Data_1_1Triggers" = {
      "items" = {
        "Comment" = "Simple_action";
        "TriggersCount" = "1";
      };
    };
    "Data_1_1Triggers0" = {
      "items" = {
        "Key" = "Meta+Shift+S";
        "Type" = "SHORTCUT";
        "Uuid" = "{2b622f4b-e7dd-4cb3-a362-b4bb59688264}";
      };
    };
    "Main" = {
      "items" = {
        "AlreadyImported" = "";
        "Disabled" = "false";
        "Version" = "2";
      };
    };
  };
  "/ksmserverrc" = {
    "General" = {
      "items" = {
        "loginMode" = "emptySession";
        "confirmLogout" = "false";
      };
    };
    "LegacySession: saved at previous logout" = {
      "items" = {
        "count" = "0";
      };
    };
  };
  "/kcminputrc" = {
    "Mouse" = {
      "items" = {
        "XLbInptAccelProfileFlat" = "true";
        "XLbInptMiddleEmulation" = "true";
        "XLbInptPointerAcceleration" = "1";
      };
    };
  };
  "/kdeglobals" = {
    "Colors:Button" = {
      "items" = {
        "BackgroundAlternate" = "64,69,82";
        "BackgroundNormal" = "29,31,35";
        "DecorationFocus" = "66,14,210";
        "DecorationHover" = "66,14,210";
        "ForegroundActive" = "61,174,233";
        "ForegroundInactive" = "102,106,115";
        "ForegroundLink" = "41,128,185";
        "ForegroundNegative" = "109,69,255";
        "ForegroundNeutral" = "255,106,0";
        "ForegroundNormal" = "195,199,209";
        "ForegroundPositive" = "113,247,159";
        "ForegroundVisited" = "33,135,252";
      };
    };
    "Colors:Complementary" = {
      "items" = {
        "BackgroundAlternate" = "20,20,33";
        "BackgroundNormal" = "30,32,36";
        "DecorationFocus" = "66,14,210";
        "DecorationHover" = "66,14,210";
        "ForegroundActive" = "0,193,228";
        "ForegroundInactive" = "102,106,115";
        "ForegroundLink" = "33,135,252";
        "ForegroundNegative" = "109,69,255";
        "ForegroundNeutral" = "255,106,0";
        "ForegroundNormal" = "211,218,227";
        "ForegroundPositive" = "113,247,159";
        "ForegroundVisited" = "124,183,255";
      };
    };
    "Colors:Header" = {
      "items" = {
        "BackgroundAlternate" = "20,20,33";
        "BackgroundNormal" = "26,28,32";
        "DecorationFocus" = "66,14,210";
        "DecorationHover" = "66,14,210";
        "ForegroundActive" = "0,193,228";
        "ForegroundInactive" = "102,106,115";
        "ForegroundLink" = "33,135,252";
        "ForegroundNegative" = "109,69,255";
        "ForegroundNeutral" = "255,106,0";
        "ForegroundNormal" = "211,218,227";
        "ForegroundPositive" = "113,247,159";
        "ForegroundVisited" = "124,183,255";
      };
      "groups" = {
        "Inactive" = {
          "items" = {
            "BackgroundAlternate" = "20,20,33";
            "BackgroundNormal" = "30,32,36";
            "DecorationFocus" = "66,14,210";
            "DecorationHover" = "66,14,210";
            "ForegroundActive" = "0,193,228";
            "ForegroundInactive" = "102,106,115";
            "ForegroundLink" = "33,135,252";
            "ForegroundNegative" = "109,69,255";
            "ForegroundNeutral" = "255,106,0";
            "ForegroundNormal" = "211,218,227";
            "ForegroundPositive" = "113,247,159";
            "ForegroundVisited" = "124,183,255";
          };
        };
      };
    };
    "Colors:Selection" = {
      "items" = {
        "BackgroundAlternate" = "29,153,243";
        "BackgroundNormal" = "66,14,210";
        "DecorationFocus" = "66,14,210";
        "DecorationHover" = "66,14,210";
        "ForegroundActive" = "252,252,252";
        "ForegroundInactive" = "211,218,227";
        "ForegroundLink" = "253,188,75";
        "ForegroundNegative" = "109,69,255";
        "ForegroundNeutral" = "255,106,0";
        "ForegroundNormal" = "254,254,254";
        "ForegroundPositive" = "113,247,159";
        "ForegroundVisited" = "189,195,199";
      };
    };
    "Colors:Tooltip" = {
      "items" = {
        "BackgroundAlternate" = "30,32,36";
        "BackgroundNormal" = "53,57,69";
        "DecorationFocus" = "66,14,210";
        "DecorationHover" = "66,14,210";
        "ForegroundActive" = "61,174,233";
        "ForegroundInactive" = "102,106,115";
        "ForegroundLink" = "41,128,185";
        "ForegroundNegative" = "109,69,255";
        "ForegroundNeutral" = "255,106,0";
        "ForegroundNormal" = "211,218,227";
        "ForegroundPositive" = "113,247,159";
        "ForegroundVisited" = "33,135,252";
      };
    };
    "Colors:View" = {
      "items" = {
        "BackgroundAlternate" = "20,20,33";
        "BackgroundNormal" = "30,32,36";
        "DecorationFocus" = "66,14,210";
        "DecorationHover" = "66,14,210";
        "ForegroundActive" = "0,193,228";
        "ForegroundInactive" = "102,106,115";
        "ForegroundLink" = "33,135,252";
        "ForegroundNegative" = "109,69,255";
        "ForegroundNeutral" = "255,106,0";
        "ForegroundNormal" = "211,218,227";
        "ForegroundPositive" = "113,247,159";
        "ForegroundVisited" = "124,183,255";
      };
    };
    "Colors:Window" = {
      "items" = {
        "BackgroundAlternate" = "30,32,36";
        "BackgroundNormal" = "26,28,32";
        "DecorationFocus" = "30,32,36";
        "DecorationHover" = "66,14,210";
        "ForegroundActive" = "61,174,233";
        "ForegroundInactive" = "102,106,115";
        "ForegroundLink" = "41,128,185";
        "ForegroundNegative" = "109,69,255";
        "ForegroundNeutral" = "255,106,0";
        "ForegroundNormal" = "211,218,227";
        "ForegroundPositive" = "113,247,159";
        "ForegroundVisited" = "179,13,191";
      };
    };
    "General" = {
      "items" = {
        "BrowserApplication" = "firefox.desktop";
        "ColorScheme" = "ArchSmooth";
      };
    };
    "Icons" = {
      "items" = {
        "Theme" = "Papirus-Dark";
      };
    };
    "KDE" = {
      "items" = {
        "AnimationDurationFactor" = "0.3";
        "ColorScheme" = "BreezeLight";
        "LookAndFeelPackage" = "Arch";
        "SingleClick" = "false";
        "contrast" = "4";
      };
    };
    "KFileDialog Settings" = {
      "items" = {
        "Allow Expansion" = "true";
        "Automatically select filename extension" = "true";
        "Breadcrumb Navigation" = "true";
        "Show Bookmarks" = "true";
        "Show Full Path" = "false";
        "Show Inline Previews" = "true";
        "Show Preview" = "false";
        "Show Speedbar" = "true";
        "Show hidden files" = "true";
        "Sort by" = "Date";
        "Sort directories first" = "true";
        "Sort reversed" = "true";
        "View Style" = "DetailTree";
      };
    };
    "WM" = {
      "items" = {
        "activeBackground" = "26,28,32";
        "activeBlend" = "30,32,36";
        "activeForeground" = "211,218,227";
        "inactiveBackground" = "30,32,36";
        "inactiveBlend" = "30,32,36";
        "inactiveForeground" = "102,106,115";
      };
    };
  };
  "/plasma-org.kde.plasma.desktop-appletsrc" = {
    # Desktop Applets
    "ActionPlugins" = {
      "groups" = {
        "11" = {
          "items" = {
            "RightButton;NoModifier" = "org.kde.contextmenu";
            "wheel:Vertical;NoModifier" = "org.kde.switchdesktop";
          };
        };
        "12" = {
          "items" = {
            "RightButton;NoModifier" = "org.kde.contextmenu";
          };
        };
      };
    };
    # Panels
    "Containments" = {
      "groups" = {
        # Desktop Background applet
        "2" = {
          "items" = {
            "ItemGeometriesHorizontal" = "";
            "activityId" = "b8c38c6a-90a5-4db9-b967-11a6c016ca90";
            "formfactor" = "0";
            "immutability" = "1";
            "lastScreen" = "0";
            "location" = "0";
            "plugin" = "org.kde.plasma.folder";
            "wallpaperplugin" = "org.kde.image";
          };
          "groups" = {
            "Wallpaper" = {
              "groups" = {
                "org.kde.image" = {
                  "groups" = {
                    "General" = {
                      "items" = {
                        "Image" = "${background}";
                      };
                    };
                  };
                };
              };
            };
          };
        };
        # Bottom Left Panel
        "3" = {
          "items" = {
            "activityId" = "";
            "formfactor" = "2";
            "immutability" = "1";
            "lastScreen" = "0";
            "location" = "4";
            "plugin" = "org.kde.panel";
            "wallpaperplugin" = "org.kde.image";
          };
          "groups" = {
            "Applets" = {
              "groups" = {
                "31" = {
                  "items" = {
                    "immutability" = "1";
                    "plugin" = "org.kde.plasma.icontasks";
                  };
                  "groups" = {
                    "Configuration" = {
                      "items" = {
                        "PreloadWeight" = "0";
                      };
                      "groups" = {
                        "General" = {
                          "items" = {
                            "launchers" = "";
                          };
                        };
                      };
                    };
                  };
                };
              };
            };
            "Configuration" = {
              "items" = {
                "PreloadWeight" = "0";
              };
            };
            "General" = {
              "items" = {
                "AppletOrder" = "31";
              };
            };
          };
        };
        # Bottom Right Panel
        "4" = {
          "items" = {
            "activityId" = "";
            "formfactor" = "2";
            "immutability" = "1";
            "lastScreen" = "0";
            "location" = "4";
            "plugin" = "org.kde.panel";
            "wallpaperplugin" = "org.kde.image";
          };
          "groups" = {
            "Applets" = {
              "groups" = {
                "41" = {
                  "items" = {
                    "immutability" = "1";
                    "plugin" = "org.kde.plasma.pager";
                  };
                };
                "42" = {
                  "items" = {
                    "immutability" = "1";
                    "plugin" = "org.kde.plasma.systemtray";
                  };
                  "groups" = {
                    "Configuration" = {
                      "items" = {
                        "PreloadWeight" = "55";
                        "SystrayContainmentId" = "5";
                      };
                    };
                  };
                };
                "43" = {
                  "items" = {
                    "immutability" = "1";
                    "plugin" = "org.kde.plasma.digitalclock";
                  };
                  "groups" = {
                    "Configuration" = {
                      "groups" = {
                        "Appearance" = {
                          "items" = {
                            "displayTimezoneFormat" = "FullText";
                            "fontWeight" = "400";
                            "showSeconds" = "2";
                            "use24hFormat" = "2";
                          };
                        };
                      };
                    };
                  };
                };
                "44" = {
                  "items" = {
                    "immutability" = "1";
                    "plugin" = "org.kde.plasma.showdesktop";
                  };
                };
              };
            };
            "General" = {
              "items" = {
                "AppletOrder" = "41;42;43";
              };
            };
          };
        };
        # Systray Bottom Right Panel
        "5" = {
          "groups" = {
            "General" = {
              "items" = {
                "extraItems" = "org.kde.plasma.volume,org.kde.plasma.battery,org.kde.plasma.bluetooth,org.kde.plasma.devicenotifier,org.kde.kscreen,org.kde.plasma.keyboardlayout,org.kde.plasma.keyboardindicator,org.kde.plasma.networkmanagement,org.kde.plasma.clipboard,org.kde.plasma.notifications,org.kde.plasma.printmanager,org.kde.plasma.mediacontroller,org.kde.plasma.brightness,org.kde.plasma.manage-inputmethod,org.kde.plasma.cameraindicator";
                "knownItems" = "org.kde.plasma.brightness,org.kde.plasma.battery,org.kde.plasma.manage-inputmethod,org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.devicenotifier,org.kde.plasma.clipboard,org.kde.plasma.mediacontroller,org.kde.plasma.bluetooth,org.kde.plasma.printmanager,org.kde.plasma.keyboardlayout,org.kde.plasma.volume,org.kde.plasma.keyboardindicator,org.kde.kscreen,org.kde.plasma.networkmanagement";
              };
            };
          };
          "items" = {
            "activityId" = "";
            "formfactor" = "2";
            "immutability" = "1";
            "lastScreen" = "0";
            "location" = "4";
            "plugin" = "org.kde.plasma.private.systemtray";
            "wallpaperplugin" = "org.kde.image";
          };
        };
        # Top Panel
        "6" = {
          "items" = {
            "activityId" = "";
            "formfactor" = "2";
            "immutability" = "1";
            "lastScreen" = "0";
            "location" = "3";
            "plugin" = "org.kde.panel";
            "wallpaperplugin" = "org.kde.image";
          };
          "groups" = {
            "Applets" = {
              "groups" = {
                "61" = {
                  "items" = {
                    "immutability" = "1";
                    "plugin" = "org.kde.plasma.appmenu";
                  };
                  "groups" = {
                    "Configuration" = {
                      "items" = {
                        "PreloadWeight" = "55";
                      };
                    };
                    "Shortcuts" = {
                      "items" = {
                        "global" = "";
                      };
                    };
                  };
                };
              };
            };
            "General" = {
              "items" = {
                "AppletOrder" = "61";
              };
            };
          };
        };
      };
    };
    "ScreenMapping" = {
      "items" = {
        "itemsOnDisabledScreens" = "";
        "screenMapping" = "";
      };
    };
  };
  "/plasmashellrc" = {
    "KFileDialog Settings" = {
      "items" = {
        "detailViewIconSize" = "16";
      };
    };
    "PlasmaViews" = {
      "groups" = {
        "Panel 3" = {
          "items" = {
            "alignment" = "1";
            "floating" = "1";
            "panelVisibility" = "1";
          };
          "groups" = {
            "Defaults" = {
              "items" = {
                "minLength" = "0";
                "thickness" = "35";
              };
            };
          };
        };
        "Panel 10" = {
          "items" = {
            "alignment" = "2";
            "floating" = "1";
            "panelVisibility" = "1";
          };
          "groups" = {
            "Defaults" = {
              "items" = {
                "minLength" = "0";
                "thickness" = "35";
              };
            };
          };
        };
        "Panel 25" = {
          "items" = {
            "alignment" = "132";
            "floating" = "1";
            "panelVisibility" = "1";
          };
          "groups" = {
            "Defaults" = {
              "items" = {
                "minLength" = "0";
                "thickness" = "35";
              };
            };
          };
        };
      };
    };
  };
  "/kwinrulesrc" = {
    "1" = {
      "items" = {
        "Description" = "Hide window border";
        "noborder" = "true";
        "noborderrule" = "2";
      };
    };
    "General" = {
      "items" = {
        "count" = "1";
        "rules" = "1";
      };
    };
  };
  "/InputLeap/InputLeap.conf" = {
    "General" = {
      "items" = {
        "autoConfig" = "false";
        "autoConfigPrompted" = "true";
        "autoHide" = "true";
        "autoStart" = "true";
        "configFile" = "${./config/barrier + ("/" + host-name + ".conf")}";
        "cryptoEnabled" = "false";
        "elevateMode" = "false";
        "elevateModeEnum" = "0";
        "groupClientChecked" = "${if host-name == "ASUS" then "false" else "true"}";
        "groupServerChecked" = "${if host-name == "ASUS" then "true" else "false"}";
        "interface" = "";
        "language" = "en";
        "logFilename" = "/var/log/barrier.log";
        "logLevel" = "3";
        "logToFile" = "false";
        "minimizeToTray" = "true";
        "port" = "24800";
        "requireClientCertificate" = "false";
        "screenName" = "${host-name}";
        "serverHostname" = "${addresses.asus}";
        "startedBefore" = "true";
        "useExternalConfig" = "true";
        "useInternalConfig" = "false";
        "wizardLastRun" = "9";
      };
    };
    "internalConfig" = {
      "items" = {
        "clipboardSharing" = "true";
        "enableDragAndDrop" = "true";
        "hasHeartbeat" = "false";
        "hasSwitchDelay" = "false";
        "hasSwitchDoubleTap" = "false";
        "heartbeat" = "5000";
        "hotkeys\\size" = "0";
        "ignoreAutoConfigClient" = "false";
        "numColumns" = "5";
        "numRows" = "3";
        "relativeMouseMoves" = "true";
        "screenSaverSync" = "true";
        "screens\\1\\name" = "";
        "screens\\10\\name" = "";
        "screens\\11\\name" = "";
        "screens\\12\\name" = "";
        "screens\\13\\name" = "";
        "screens\\14\\name" = "";
        "screens\\15\\name" = "";
        "screens\\2\\name" = "";
        "screens\\3\\name" = "";
        "screens\\4\\name" = "";
        "screens\\5\\name" = "";
        "screens\\6\\name" = "";
        "screens\\7\\aliasArray\\size" = "0";
        "screens\\7\\fixArray\\1\\fix" = "true";
        "screens\\7\\fixArray\\2\\fix" = "true";
        "screens\\7\\fixArray\\3\\fix" = "true";
        "screens\\7\\fixArray\\4\\fix" = "true";
        "screens\\7\\fixArray\\5\\fix" = "true";
        "screens\\7\\fixArray\\size" = "5";
        "screens\\7\\modifierArray\\1\\modifier" = "0";
        "screens\\7\\modifierArray\\2\\modifier" = "1";
        "screens\\7\\modifierArray\\3\\modifier" = "2";
        "screens\\7\\modifierArray\\4\\modifier" = "3";
        "screens\\7\\modifierArray\\5\\modifier" = "4";
        "screens\\7\\modifierArray\\6\\modifier" = "5";
        "screens\\7\\modifierArray\\size" = "6";
        "screens\\7\\name" = "MSI";
        "screens\\7\\switchCornerArray\\1\\switchCorner" = "true";
        "screens\\7\\switchCornerArray\\2\\switchCorner" = "true";
        "screens\\7\\switchCornerArray\\3\\switchCorner" = "true";
        "screens\\7\\switchCornerArray\\4\\switchCorner" = "true";
        "screens\\7\\switchCornerArray\\size" = "4";
        "screens\\7\\switchCornerSize" = "5";
        "screens\\8\\aliasArray\\size" = "0";
        "screens\\8\\fixArray\\1\\fix" = "true";
        "screens\\8\\fixArray\\2\\fix" = "true";
        "screens\\8\\fixArray\\3\\fix" = "true";
        "screens\\8\\fixArray\\4\\fix" = "true";
        "screens\\8\\fixArray\\5\\fix" = "true";
        "screens\\8\\fixArray\\size" = "5";
        "screens\\8\\modifierArray\\1\\modifier" = "0";
        "screens\\8\\modifierArray\\2\\modifier" = "1";
        "screens\\8\\modifierArray\\3\\modifier" = "2";
        "screens\\8\\modifierArray\\4\\modifier" = "3";
        "screens\\8\\modifierArray\\5\\modifier" = "4";
        "screens\\8\\modifierArray\\6\\modifier" = "5";
        "screens\\8\\modifierArray\\size" = "6";
        "screens\\8\\name" = "ROG";
        "screens\\8\\switchCornerArray\\1\\switchCorner" = "true";
        "screens\\8\\switchCornerArray\\2\\switchCorner" = "true";
        "screens\\8\\switchCornerArray\\3\\switchCorner" = "true";
        "screens\\8\\switchCornerArray\\4\\switchCorner" = "true";
        "screens\\8\\switchCornerArray\\size" = "4";
        "screens\\8\\switchCornerSize" = "5";
        "screens\\9\\aliasArray\\size" = "0";
        "screens\\9\\fixArray\\1\\fix" = "false";
        "screens\\9\\fixArray\\2\\fix" = "false";
        "screens\\9\\fixArray\\3\\fix" = "false";
        "screens\\9\\fixArray\\4\\fix" = "false";
        "screens\\9\\fixArray\\5\\fix" = "false";
        "screens\\9\\fixArray\\size" = "5";
        "screens\\9\\modifierArray\\1\\modifier" = "0";
        "screens\\9\\modifierArray\\2\\modifier" = "1";
        "screens\\9\\modifierArray\\3\\modifier" = "2";
        "screens\\9\\modifierArray\\4\\modifier" = "3";
        "screens\\9\\modifierArray\\5\\modifier" = "4";
        "screens\\9\\modifierArray\\6\\modifier" = "5";
        "screens\\9\\modifierArray\\size" = "6";
        "screens\\9\\name" = "ASUS";
        "screens\\9\\switchCornerArray\\1\\switchCorner" = "true";
        "screens\\9\\switchCornerArray\\2\\switchCorner" = "true";
        "screens\\9\\switchCornerArray\\3\\switchCorner" = "true";
        "screens\\9\\switchCornerArray\\4\\switchCorner" = "true";
        "screens\\9\\switchCornerArray\\size" = "4";
        "screens\\9\\switchCornerSize" = "5";
        "switchCornerArray\\1\\switchCorner" = "true";
        "switchCornerArray\\2\\switchCorner" = "true";
        "switchCornerArray\\3\\switchCorner" = "true";
        "switchCornerArray\\4\\switchCorner" = "true";
        "switchCornerArray\\size" = "4";
        "switchCornerSize" = "5";
        "switchDelay" = "250";
        "switchDoubleTap" = "250";
        "win32KeepForeground" = "false";
      };
    };
  };
  "obs-studio" = {
    "General" = {
      "Pre19Defaults" = "false";
      "Pre21Defaults" = "false";
      "Pre23Defaults" = "false";
      "Pre24.1Defaults" = "false";
      "FirstRun" = "true";
    };
    "Basic" = {
      "Profile" = "Untitled";
      "ProfileDir" = "Untitled";
      "SceneCollection" = "Untitled";
      "SceneCollectionFile" = "Untitled";
    };
  };
} // (if host-name == "ROG" then {
  "/kcmfonts" = {
    "General" = {
      "items" = {
        "forceFontDPI" = "144";
      };
    };
  };
} else {})