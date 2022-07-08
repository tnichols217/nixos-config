{ config, pkgs, username, ... }:
{
  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/data" = {
    hideMounts = false;
    users.${username} = {
      directories = [
        { directory = "Downloads"; user = "${username}"; }
        { directory = "Desktop"; user = "${username}"; }
        { directory = "Music"; user = "${username}"; }
        { directory = "Pictures"; user = "${username}"; }
        { directory = "Documents"; user = "${username}"; }
        { directory = "Videos"; user = "${username}"; }
        { directory = ".gnupg"; mode = "0700"; user = "${username}";}
        { directory = ".ssh"; mode = "0700"; user = "${username}"; }
        { directory = ".nixops"; mode = "0700"; user = "${username}"; }
      ];
    };
  };

  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/local" = {
    hideMounts = false;
    users.${username} = {
      directories = [
        { directory = ".steam"; user = "${username}"; }
        { directory = ".local/share/barrier"; user = "${username}"; }
        { directory = ".local/share/Steam"; user = "${username}"; }
        { directory = ".local/share/TelegramDesktop"; user = "${username}"; }
        { directory = ".config/discordptb"; user = "${username}"; }
        { directory = ".config/libvirt"; mode = "0700"; user = "${username}"; }
        { directory = ".config/spotify"; user = "${username}"; }
      ];
    };
  };
}