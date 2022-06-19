{ config, pkgs, impermanence, ... }:
{
  imports =
    [
      impermanence.nixosModule
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