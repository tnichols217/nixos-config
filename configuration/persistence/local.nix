{ config, pkgs, ... }:
{
  environment.persistence."/nix/persist/etc/nixos/configuration/persistence/local" = {
    hideMounts = false;
    directories = [
      "/var/log"
      "/var/lib/openvpn"
      "/var/lib/bluetooth"
      "/var/lib/acme"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/letsencrypt"
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