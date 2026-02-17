{ host-name, ... }:
let
  wallpaper = import ./hyprpaper/background.nix { inherit host-name; };
in
''
  wallpaper {
    monitor = 
    path = ${wallpaper}
  }
  splash = false
''