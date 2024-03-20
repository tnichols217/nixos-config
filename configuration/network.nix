{ config, pkgs, host-name, ... }:
{
  imports =
    if host-name != "ASUS" then [
      ./network/openvpn.nix
     ] else [];
  networking.hostName = host-name;
  hardware.enableRedistributableFirmware = true;
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [
      80 # Nginx
      443 # Nginx
      8000
      4430
      24800 # Barrier
      25565 # Minecraft
      9009 # qbittorrent
      #TODO add binary cache
    ];
  };
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

  services.dbus.packages = [
    pkgs.miraclecast
  ];
}