{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ../../metapkgs/combine.metapkg.nix { pack = [
  (pkgs.callPackage ./autostart/save-desktop.pkg.nix { app = pkgs.flameshot; name = "org.flameshot.Flameshot"; })
  (pkgs.callPackage ./autostart/save-desktop.pkg.nix { app = pkgs.barrier; name = "barrier"; })
  (pkgs.callPackage ./autostart/custom-autostart.pkg.nix { pkg = pkgs.ibus; name = "ibus-daemon"; })
  (pkgs.callPackage ./autostart/custom-autostart.pkg.nix { exec = ""; name = "bash"; args = let 
    plugin = "org.kde.image";
    wp = import ./rc/config/background.nix;
  in "${pkgs.writeScriptBin "setWallpaper" ''
  qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
    var alreadySet = false
    while (!alreadySet) {
      var allDesktops = desktops()
      alreadySet = allDesktops.map((d) => {
        d.currentConfigGroup = Array("Wallpaper", "${plugin}", "General")
        return d.readConfig("Image") == "file://${wp}"
      }).every(a => a) && allDesktops.length > 0
      print(alreadySet)
      allDesktops.forEach((d) => {
        d.wallpaperPlugin = "${plugin}";
        d.currentConfigGroup = Array("Wallpaper", "${plugin}", "General");
        d.writeConfig("Image", "file://${wp}")
      })
    }';''}" + "/bin/setWallpaper"; })
]; }