{ config, pkgs, host-name, ... }:
{
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.hostName = host-name;
  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    networks = {
      "NICHOLS 5Ghz" = {
        pskRaw = "1c1f10514c30ccab217b1a1c96b6dab18d72f7cc0ab24ea0be8ec37d47d893e7";
      };
    };
  };
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
}