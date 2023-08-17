{ config, pkgs, username, ... }:
{
  environment.persistence = let 
      mapDir = ( x: { directory = x; mode = "0700"; user = "${username}"; } );
      mapFile = ( x: { file = x; parentDirectory = { mode = "700"; user = "${username}"; }; } );
    in {
    "/nix/persist/etc/nixos/configuration/persistence/data" = {
      hideMounts = false;
      users.${username} = {
        directories = pkgs.lib.lists.map mapDir [
          "Downloads"
          "Desktop"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "Public"
          "Templates"
        ];
      };
    };
    "/nix/persist/etc/nixos/configuration/persistence/bucket" = {
      hideMounts = false;
      users.${username} = {
        directories = pkgs.lib.lists.map mapDir [
          ".local/share/Steam"
          ".steam"
          ".local/share/osu"
          ".local/share/shapez.io"
          ".local/share/lutris"
          ".local/share/SHENZHEN IO"
          ".local/share/Celeste"
          ".local/share/dolphin-emu"
          ".minecraft"
          "Games"
          ".wine"
        ];
      };
    };
    "/nix/persist/etc/nixos/configuration/persistence/local" = {
      hideMounts = false;
      users.${username} = {
        directories = pkgs.lib.lists.map mapDir [
          ".ssh"
          ".gnupg"
          ".nixops"
          ".mozilla"
          ".local/share/PolyMC" # move to prismlauncher
          ".local/share/PrismLauncher" # move to prismlauncher
          ".local/share/barrier"
          ".local/share/TelegramDesktop"
          ".local/share/kwalletd"
          ".local/share/kscreen"
          ".local/share/direnv/allow"
          ".local/share/MuseScore"
          ".config/lutris"
          ".config/kdeconnect"
          ".config/VSCodium"
          ".config/discord"
          ".config/Microsoft/Microsoft Teams"
          ".config/teams"
          ".config/obsidian"
          ".config/libvirt"
          ".config/spotify"
          ".config/obs-studio/basic"
          ".config/obs-studio/plugin_config"
          ".config/dolphin-emu"
          ".config/xsettingsd"
        ];
        files = pkgs.lib.lists.map mapFile [
          ".config/gh/hosts.yml"
          ".local/share/applications/steam.desktop"
          ".config/cachix/cachix.dhall"
        ];
      };
    };
  };
}
