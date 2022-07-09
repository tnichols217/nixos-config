{ config, pkgs, host-name, ... }:
{
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.hostName = host-name;
  # networking.wireless = {
  #   enable = true;
  #   userControlled.enable = true;
  #   networks = {
  #     "NICHOLS 5Ghz" = {
  #       psk = "0194815801";
  #     };
  #   };
  # };
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
}