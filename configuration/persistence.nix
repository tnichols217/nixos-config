{ config, pkgs, impermanence, ... }:
{
  imports =
    [
      ./persistence/data.nix
      ./persistence/local.nix
    ];
  environment.persistence."/nix/persist" = {
    hideMounts = false;
    directories = [
      "/etc/nixos"
    ];
  };
}