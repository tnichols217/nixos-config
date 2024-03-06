{ pkgs, attrs, config, ... }:
{
  imports = [
    ./ASUS/acme.nix
    ./ASUS/arion.nix
    ./ASUS/cron.nix
    ./ASUS/hardware.nix
    ./ASUS/networking.nix
    # ./ASUS/nextcloud.nix
    ./ASUS/nginx.nix
    ./ASUS/nix-serve.nix
    ./ASUS/ovpn.nix
    ./ASUS/pipewire.nix
    ./ASUS/servarr.nix
    ./ASUS/antivirus.nix
  ];
}