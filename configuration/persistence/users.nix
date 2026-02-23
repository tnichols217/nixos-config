{ ... }:
{
  # Define all undefined users here so we don't need to persist /var/lib/nixos
  users = {
    groups = {
      avahi.gid = 999;
      flatpak.gid = 998;
      gamemode.gid = 997;
      geoclue.gid = 996;
      greeter.gid = 995;
      nscd.gid = 994;
      podman.gid = 993;
      polkituser.gid = 992;
      resolvconf.gid = 991;
      sshd.gid = 990;
      systemd-coredump.gid = 989;
      systemd-oom.gid = 988;
      wpa_supplicant.gid = 987;
    };
    users = {
      avahi.uid = 999;
      flatpak.uid = 998;
      geoclue.uid = 997;
      greeter.uid = 996;
      nm-iodine.uid = 995;
      nscd.uid = 994;
      sshd.uid = 993;
      systemd-oom.uid = 992;
      wpa_supplicant.uid = 991;

      soda.uid = 1000;
      tev.uid = 1001;
    };
  };
}