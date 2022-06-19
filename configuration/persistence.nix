{ config, pkgs, impermanence, ... }:
{
  imports =
    [
      ./persistence/cache.nix
      ./persistence/config.nix
      ./persistence/data.nix
    ];
  environment.persistence."/nix/persist" = {
    hideMounts = false;
    directories = [
      "/etc/nixos"
    ];
  };
}