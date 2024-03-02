{ persistence, ... } :
{
  services.lidarr = {
    enable = true;
    dataDir = "${persistence.bucket}/var/lib/lidarr/.config/Lidarr"
  };
}