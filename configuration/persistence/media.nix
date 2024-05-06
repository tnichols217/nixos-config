{ config, pkgs, persistence, ... }:
{
  environment.persistence."${persistence.media}" = {
    hideMounts = false;
    directories = [
      "/var/lib/lidarr/data"
      "/var/lib/radarr/data"
      "/var/lib/sonarr/data"
      "/var/lib/readarr/data"
      "/var/lib/transmission"
      "/var/lib/qbittorrent"
    ];
  };
}