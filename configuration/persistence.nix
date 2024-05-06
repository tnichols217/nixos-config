{ config, pkgs, persistence, host-name, ... }:
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