{ pkgs ? import <nixpkgs> {}, host-name, inputs }:
pkgs.callPackage ../../metapkgs/combine.metapkg.nix { pack = [
  (pkgs.callPackage ./autostart/save-desktop.pkg.nix { app = pkgs.flameshot; name = "org.flameshot.Flameshot"; })
  (pkgs.callPackage ./autostart/custom-autostart.pkg.nix { pkg = pkgs.sunshine; name = "sunshine"; delim = ""; })
  (pkgs.callPackage ./autostart/custom-autostart.pkg.nix { pkg = pkgs.bash; name = "bash"; args = let
    algo = "ed25519";
    plugin = "org.kde.image";
    wp = (import ./rc/config/background.nix { inherit host-name; });
  in "${pkgs.writeScriptBin "setWallpaper" ''
    if [ ! -f ~/.ssh/${algo} ]; then
      ssh-keygen -t ${algo} -f ~/.ssh/${algo} -N ""
    fi
    sed 's~Exec=kitty~Exec=${pkgs.callPackage ../../../templates/default_home_manager/shell/kitty/kitty.pkg.nix { self = pkgs; inherit inputs; }}/bin/kitty~' ~/.nix-profile/share/applications/kitty.desktop > ~/.local/share/applications/kitty.desktop
    ${if host-name == "MSI" then ''
    sed 's/^Exec=/&nvidia-offload /' /run/current-system/sw/share/applications/steam.desktop > ~/.local/share/applications/steam.desktop
    sed 's/^Exec=/&nvidia-offload /' ~/.nix-profile/share/applications/dolphin-emu.desktop > ~/.local/share/applications/dolphin-emu.desktop
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