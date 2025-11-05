{ ports, ... }:
{
  users.users.immich.extraGroups = [ "video" "render" ];
  services.immich = {
    enable = true;
    port = ports.immich;
    accelerationDevices = null;
    mediaLocation = "/var/lib/immich";
  }
}