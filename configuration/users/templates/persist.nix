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
          ".minecraft"
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
          ".tlauncher"
          ".local/share/barrier"
          ".local/share/TelegramDesktop"
          ".local/share/kwalletd"
          ".local/share/kscreen"
          ".config/discord"
          ".config/obsidian"
          ".config/libvirt"
          ".config/spotify"
          ".config/obs-studio/basic"
          ".config/obs-studio/plugin_config"
        ];
        files = pkgs.lib.lists.map mapFile [
          ".config/gh/hosts.yml"
          ".local/share/applications/steam.desktop"
        ];
      };
    };
  };
}