{ ports, ... }:
{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "tplink"
    ];
    configDir = "/var/lib/hass";
    config = {
      http.server_port = ports.home-assistant;
      homeassistant.unit_system = "metric";
    };
  };
}