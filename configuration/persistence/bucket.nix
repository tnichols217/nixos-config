{ config, pkgs, persistence, ... }:
{
  environment.persistence."${persistence.bucket}" = {
    hideMounts = false;
    directories = [
      "/var/lib/libvirt"
      "/var/lib/waydroid"
      "/var/lib/container-storage/volumes"
      "/var/lib/nextcloud/data"
      "/var/lib/lidarr/data"
      "/var/lib/radarr/data"
      "/var/lib/sonarr/data"
      "/var/lib/readarr/data"
      "/var/lib/transmission"
    ];
  };
}