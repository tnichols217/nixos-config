{ config, pkgs, host-name, ... }:
{
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.hostName = host-name;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
}