{ config, pkgs, ... }:
{
  environment.persistence."${./config}" = {
    hideMounts = false;
    directories = [
      "/etc/nixos"
    ];
    files = [
    ];
  };
}