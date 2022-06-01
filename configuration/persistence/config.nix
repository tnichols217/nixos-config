{ config, pkgs, ... }:
{
  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/config" = {
    hideMounts = false;
    directories = [
      "/etc/nixos"
    ];
    files = [
    ];
  };
}