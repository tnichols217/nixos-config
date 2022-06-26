{ config, pkgs, hostname, ... }:
{
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.hostName = hostname;
  # networking.interfaces.enp1s0.useDHCP = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}