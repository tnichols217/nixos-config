{ host-name, ... }:
let
  wallpaper = import ./hyprpaper/background.nix { inherit host-name; };
in
''
preload=${wallpaper}
wallpaper=,${wallpaper}
splash = false
ipc = false
''