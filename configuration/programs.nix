{ config, pkgs, ... }:
{
  services.flatpak.enable = true;
  virtualisation.waydroid.enable = true;
}