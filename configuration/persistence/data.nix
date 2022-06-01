{ config, pkgs, ... }:
{
  environment.persistence."/etc/nixos/configuration/persistence/data" = {
    hideMounts = false;
    directories = [
    ];
    files = [
    ];
  };
}