{ config, pkgs, host-name, ... }:
{
  # networking.useDHCP = false;
  networking.hostName = host-name;
  hardware.enableRedistributableFirmware = true;
  networking.firewall.enable = false;
}