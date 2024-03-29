{ config, pkgs, persistence, ... }:
{
  environment.persistence."${persistence.local}" = {
    hideMounts = false;
    directories = [
      "/var/log"
      "/var/lib/openvpn"
      "/var/lib/bluetooth"
      "/var/lib/acme"
      "/var/lib/systemd/coredump"
      "/var/lib/nix-serve"
      "/var/lib/nextcloud"
      "/etc/NetworkManager/system-connections"
      "/etc/letsencrypt"
      "/var/lib/lidarr/.config"
      "/var/lib/radarr/.config"
      "/var/lib/sonarr/.config"
      "/var/lib/readarr/.config"
      "/var/lib/www-allow"
      "/var/lib/private/prowlarr"
      "/var/lib/jellyfin"
      "/var/lib/mullvad"
      "/var/lib/authelia"
      # "/etc/ssh"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/etc/nix/id_rsa"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}