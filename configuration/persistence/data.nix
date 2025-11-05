{ config, pkgs, persistence, ... }:
{
  environment.persistence."${persistence.data}" = {
    hideMounts = false;
    directories = [
      "/root"
      "/var/lib/immich"
      "/var/lib/postgresql"
    ];
  };
}