{ config, pkgs, username, persistence, lib, ... }:
{
  imports = let 
    mapDirAttr = ( x: { directory = x; mode = "0700"; user = "${username}"; } );
    mapFileAttr = ( x: { file = x; parentDirectory = { mode = "700"; user = "${username}"; }; } );
    mapTmp = ( x: "Z! /home/${username}/${lib.strings.stringAsChars (c: if c == " " then "\\x20" else c) x} 0700 ${username} users" );
    mapConf = ( files: dirs: loc: {
      environment.persistence."${loc}" = {
        hideMounts = false;
        users.${username} = {
          directories = pkgs.lib.lists.map mapDirAttr dirs;
          files = pkgs.lib.lists.map mapFileAttr files;
        };
      };
      systemd.tmpfiles.rules = pkgs.lib.lists.map mapTmp dirs ++ pkgs.lib.lists.map mapTmp files;
    } );
  in [
    (
      mapConf [] [
        "Downloads"
        "Desktop"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "Public"
        "Templates"
        "Calibre Library"
      ] "${persistence.data}"
    )
    (
      mapConf [] [
        ".local/share/Steam"
        ".steam"
        ".local/share/osu"
        ".local/share/shapez.io"
        ".local/share/lutris"
        ".local/share/SHENZHEN IO"
        ".local/share/Celeste"
        ".local/share/dolphin-emu"
        ".local/share/waydroid"
        ".local/share/ryujinx"
        ".minecraft"
        "Games"
        ".wine"
      ] "${persistence.bucket}"
    )
    (
      mapConf [
        ".config/gh/hosts.yml"
        ".config/cachix/cachix.dhall"
      ] [
        ".ssh"
        ".gnupg"
        ".nixops"
        ".mozilla"
        # ".local/state/nix/profiles"
        ".local/share/PolyMC" # move to prismlauncher
        ".local/share/PrismLauncher" # move to prismlauncher
        ".local/share/TelegramDesktop"
        ".local/share/kwalletd"
        ".local/share/kscreen"
        ".local/share/direnv/allow"
        ".local/share/MuseScore"
        ".local/share/Anki2"
        ".local/share/jellyfinmediaplayer"
        ".local/share/Jellyfin Media Player"
        ".local/share/suyu"
        ".local/share/yuzu"
        ".local/share/DBeaverData"
        ".config/suyu"
        ".config/yuzu"
        ".config/Ryujinx"
        ".config/matlab/installation"
        ".config/jellyfin.org"
        ".config/lutris"
        ".config/kdeconnect"
        ".config/VSCodium"
        ".config/discord/Local Storage"
        ".config/Element"
        ".config/Signal"
        ".config/tidal-hifi"
        ".config/Microsoft/Microsoft Teams"
        ".config/teams"
        ".config/obsidian"
        ".config/libvirt"
        ".config/spotify"
        ".config/obs-studio/basic"
        ".config/obs-studio/plugin_config"
        ".config/dolphin-emu"
        ".config/calibre"
        ".config/sunshine/credentials"
        ".config/Moonlight Game Streaming Project"
        ".config/Yubico"
        ".config/tartube"
      ] "${persistence.local}"
    )
  ];
}
