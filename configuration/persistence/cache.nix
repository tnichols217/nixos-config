{ config, pkgs, ... }:
{
  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/cache" = {
    hideMounts = false;
    directories = [
    ];
    files = [
    ];
  };
}