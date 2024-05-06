{ config, pkgs, persistence, ... }:
{
  imports =
    [
      ./persistence/data.nix
      ./persistence/local.nix
      ./persistence/bucket.nix
    ] ++ (if host-name == "ASUS" then [
      ./persistence/media.nix
    ] else []);
  environment.persistence."${persistence.local}" = {
    hideMounts = false;
    directories = [
      "/etc/nixos"
    ];
  };
}