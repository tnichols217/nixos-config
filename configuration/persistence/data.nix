{ config, pkgs, ... }:
{
  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/data" = {
    hideMounts = false;
    directories = [
    ];
    files = [
    ];
  };
}