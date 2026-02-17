{ host-name, ... }:
let
  wallpaper = import ./hyprpaper/background.nix { inherit host-name; };
in
''
  wallpaper {
    path=${wallpaper}
  }
  splash = false
''