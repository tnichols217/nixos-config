{ config, pkgs, persistence, ... }:
{
  environment.persistence."${persistence.bucket}" = {
    hideMounts = false;
    directories = [
      "/var/lib/libvirt"
      "/var/lib/waydroid"
      "/var/lib/container-storage/volumes"
      "/var/lib/nextcloud/data"
      "/var/lib/lidarr"
      "/var/lib/private/prowlarr"
      "/var/lib/jellyfin"
      "/var/lib/transmission"
    ];
  };
}