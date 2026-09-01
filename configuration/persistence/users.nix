{lib, ...}: {
  # Overrides for stubborn modules
  ids.gids.networkmanager = lib.mkForce 991;
  # Define all undefined users here so we don't need to persist /var/lib/nixos
  users = {
    groups = {
      acme.gid = 999;
      avahi.gid = 998;
      flatpak.gid = 997;
      gamemode.gid = 996;
      geoclue.gid = 995;
      github-runner.gid = 994;
      greeter.gid = 993;
      immich.gid = 992;
      networkmanager.gid = 991;
      nscd.gid = 990;
      podman.gid = 989;
      polkituser.gid = 988;
      redis-immich.gid = 987;
      resolvconf.gid = 986;
      sshd.gid = 985;
      systemd-coredump.gid = 984;
      systemd-oom.gid = 983;
      wpa_supplicant.gid = 982;
    };
    users = {
      acme = {
        uid = 999;
        group = "acme";
      };
      avahi.uid = 998;
      flatpak.uid = 997;
      geoclue.uid = 996;
      github-runner = {
        uid = 995;
        group = "github-runner";
      };
      greeter.uid = 994;
      immich = {
        uid = 993;
        group = "immich";
      };
      nm-iodine = {
        uid = 992;
        group = "networkmanager";
      };
      nscd.uid = 991;
      redis-immich = {
        uid = 990;
        group = "redis-immich";
      };
      sshd.uid = 989;
      systemd-oom.uid = 988;
      wpa_supplicant = {
        uid = 987;
        group = "wpa_supplicant";
      };
      soda.uid = 1000;
      tev.uid = 1001;
    };
  };
}
