{ ports, ... }:
{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "esphome"
      "met"
      "radio_browser"
      "tplink"
    ];
    extraPackages =  python3Packages: with python3Packages; [
      psycopg2
      numpy
      aiodhcpwatcher
      aioesphomeapi
      aiohttp-cors
      aiodiscover
      ifaddr
      zeroconf
    ];
    configDir = "/var/lib/hass";
    config = {
      http.server_port = ports.home-assistant;
      homeassistant.unit_system = "metric";
    };
  };
}