{ ports, ... }:
{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "tplink"
    ];
    extraPackages =  python3Packages: with python3Packages; [
      psycopg2
      numpy
      aiodhcpwatcher
    ];
    configDir = "/var/lib/hass";
    config = {
      http.server_port = ports.home-assistant;
      homeassistant.unit_system = "metric";
    };
  };
}