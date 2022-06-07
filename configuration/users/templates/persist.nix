{ username }:
{ config, pkgs, ... }:
{
  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/data" = {
    hideMounts = false;
    users.${username} = {
      directories = [
          { directory = "Downloads"; user = "${username}"; }
          { directory = "Music"; user = "${username}"; }
          { directory = "Pictures"; user = "${username}"; }
          { directory = "Documents"; user = "${username}"; }
          { directory = "Videos"; user = "${username}"; }
          { directory = ".gnupg"; mode = "0700"; user = "${username}";}
          { directory = ".ssh"; mode = "0700"; user = "${username}"; }
          { directory = ".nixops"; mode = "0700"; user = "${username}"; }
          { directory = ".local/share/keyrings"; mode = "0700"; user = "${username}"; }
      ];
      files = [
      ];
    };
  };

  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/local" = {
    hideMounts = false;
    users.${username} = {
      directories = [
        { directory = ".local"; user = "${username}"; }
      ];
    };
  };

  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/config" = {
    hideMounts = false;
    users.${username} = {
      directories = [
        { directory = ".config"; user = "${username}"; }
      ];
    };
  };
}