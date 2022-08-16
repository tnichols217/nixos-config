{ config, pkgs, host-name, ... }:
{
  imports =
    if host-name != "ASUS" then [
      ./network/openvpn.nix
     ] else [];
  networking.hostName = host-name;
  hardware.enableRedistributableFirmware = true;
  networking.firewall.enable = false;
  networking.timeServers = [
      "0.nixos.pool.ntp.org"
      "1.nixos.pool.ntp.org"
      "2.nixos.pool.ntp.org"
      "3.nixos.pool.ntp.org"
      "time.google.com"
      "time2.google.com"
      "time3.google.com"
      "time4.google.com"
  ];
}