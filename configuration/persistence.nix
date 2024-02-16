{ config, pkgs, persistence, ... }:
{
  imports =
    [
      ./persistence/data.nix
      ./persistence/local.nix
      ./persistence/bucket.nix
    ];
  environment.persistence."${persistence.local}" = {
    hideMounts = false;
    directories = [
      "/etc/nixos"
    ];
  };
}