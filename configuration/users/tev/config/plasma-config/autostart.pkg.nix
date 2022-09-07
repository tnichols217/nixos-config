{ pkgs ? import <nixpkgs> {}, host-name }:
pkgs.callPackage ../../metapkgs/combine.metapkg.nix { pack = [
  (pkgs.callPackage ./autostart/save-desktop.pkg.nix { app = pkgs.flameshot; name = "org.flameshot.Flameshot"; })
  (pkgs.callPackage ./autostart/save-desktop.pkg.nix { app = pkgs.barrier; name = "barrier"; })
  (pkgs.callPackage ./autostart/custom-autostart.pkg.nix { pkg = pkgs.cachix; name = "cachix"; args = "watch-store tnichols217-nixos-config"; })
  (pkgs.callPackage ./autostart/custom-autostart.pkg.nix { exec = ""; name = "bash"; args = let
    algo = "ed25519";
    plugin = "org.kde.image";
    wp = (import ./rc/config/background.nix { inherit host-name; });
  in "${pkgs.writeScriptBin "setWallpaper" ''
    if [ ! -f ~/.ssh/${algo} ]; then
      ssh-keygen -t ${algo} -f ~/.ssh/${algo} -N ""
    fi
    ${if host-name == "MSI" then ''
    if [ ! -f ~/.local/share/applications/steam.desktop ]; then
      sed 's/^Exec=/&nvidia-offload /' /run/current-system/sw/share/applications/steam.desktop > ~/.local/share/applications/steam.desktop
    fi
    if [ ! -f ~/.local/share/applications/org.polymc.PolyMC.desktop ]; then
      sed 's/^Exec=/&nvidia-offload /' /run/current-system/sw/share/applications/org.polymc.PolyMC.desktop > ~/.local/share/applications/org.polymc.PolyMC.desktop
    fi
    '' else ""}
    while true;
    do qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
      var alreadySet = false
      var allDesktops = desktops()
      allDesktops.forEach((d) => {
        d.wallpaperPlugin = "${plugin}";
        d.currentConfigGroup = Array("Wallpaper", "${plugin}", "General");
        d.writeConfig("Image", "file://${wp}")
      })
    ';
    sleep 10;
    done''}" + "/bin/setWallpaper"; })

]; }