{ config, pkgs, ... }:
{
  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/bucket" = {
    hideMounts = false;
    directories = [
      "/var/lib/libvirt"
      "/var/lib/waydroid"
      "/var/lib/container-storage/volumes"
    ];
  };
}