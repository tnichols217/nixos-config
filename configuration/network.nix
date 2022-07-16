{ config, pkgs, host-name, ... }:
{
  networking.hostName = host-name;
  hardware.enableRedistributableFirmware = true;
  networking.firewall.enable = false;
}