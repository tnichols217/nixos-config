{ ports, ... }:
{
  systemd.tmpfiles.rules = [
    "Z /var/lib/immich 2775 immich immich"
  ];
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];
  services.immich = {
    enable = true;
    port = ports.immich;
    accelerationDevices = null;
    mediaLocation = "/var/lib/immich";
    machine-learning = {
      enable = true;
      environment = {
        LD_LIBRARY_PATH = "/run/opengl-driver/lib";
      };
    };
  };
}
