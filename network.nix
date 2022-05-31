{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;
}