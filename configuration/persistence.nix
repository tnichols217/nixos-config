{ config, pkgs, impermanence, ... }:
{
  imports =
    [
      (import "${impermanence}/nixos.nix")
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