{ config, pkgs, username, ... }:
{
  environment.persistence = let 
      mapDir = ( x: { directory = x; mode = "0700"; user = "${username}"; } );
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
          ".steam"
          ".mozilla"
          ".local/share/barrier"
          ".local/share/Steam"
          ".local/share/osu"
          ".local/share/TelegramDesktop"
          ".local/share/kwalletd"
          ".local/share/kscreen"
          ".config/discordptb"
          ".config/libvirt"
          ".config/spotify"
        ];
      };
    };
  };
}