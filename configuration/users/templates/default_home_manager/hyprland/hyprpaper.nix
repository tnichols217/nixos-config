{ host-name, ... }:
let
  wallpaper = import ./hyprpaper/background.nix {host-name};
in
''
preload=${wallpaper}
wallpaper=,${wallpaper}
''