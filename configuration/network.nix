{ config, pkgs, host-name, ... }:
{
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.hostName = host-name;
  hardware.enableRedistributableFirmware = true;
  networking.firewall.enable = false;
}