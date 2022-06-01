{ config, pkgs, ... }:
{
  environment.persistence."/etc/nixos/configuration/persistence/config" = {
    hideMounts = false;
    directories = [
      "/etc/nixos"
    ];
    files = [
    ];
  };
}